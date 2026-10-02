#!/usr/bin/env python3
"""Pin the latest stable Find Yoshi IT release after checking its asset hash."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tempfile

REPO = "goldberg-consulting/find-yoshi-it"
CASK = Path(__file__).resolve().parents[1] / "Casks/find-yoshi-it.rb"


def version_tuple(version):
    if not re.fullmatch(r"\d+\.\d+\.\d+", version):
        raise ValueError("Expected a stable three-part version")
    return tuple(map(int, version.split(".")))


def release_asset(release):
    if release.get("draft") or release.get("prerelease"):
        raise ValueError("Only published stable releases can update the cask")
    tag = release["tag_name"]
    if not tag.startswith("v"):
        raise ValueError("Expected a v-prefixed release tag")
    version = tag[1:]
    version_tuple(version)
    name = f"Find-Yoshi-IT-v{version}-macOS-arm64.zip"
    assets = {asset["name"]: asset for asset in release["assets"]}
    for required in (name, "SHA256SUMS.txt"):
        if required not in assets or assets[required]["state"] != "uploaded":
            raise ValueError(f"Release asset is not ready: {required}")
    if not 0 < assets[name]["size"] <= 512 * 1024 * 1024:
        raise ValueError("Unexpected release archive size")
    return version, name


def verify_checksum(archive, checksums):
    matches = re.findall(r"^([a-fA-F0-9]{64})\s+\*?" + re.escape(archive.name) + r"$", checksums, re.MULTILINE)
    if len(matches) != 1:
        raise ValueError("Expected exactly one checksum for the release archive")
    with archive.open("rb") as stream:
        digest = hashlib.file_digest(stream, "sha256").hexdigest()
    if digest != matches[0].lower():
        raise ValueError("Release archive checksum mismatch")
    return digest


def main():
    release = json.loads(subprocess.check_output(["gh", "api", f"repos/{REPO}/releases/latest"]))
    version, asset = release_asset(release)
    content = CASK.read_text()
    current = re.search(r'^  version "([^"]+)"$', content, re.MULTILINE).group(1)
    if version_tuple(version) < version_tuple(current):
        raise ValueError("Refusing to downgrade the cask")
    if version == current:
        print(f"Cask is already at {version}; existing checksum remains pinned.")
        return
    with tempfile.TemporaryDirectory() as folder:
        subprocess.run(["gh", "release", "download", "v" + version, "--repo", REPO,
                        "--pattern", asset, "--pattern", "SHA256SUMS.txt", "--dir", folder], check=True)
        digest = verify_checksum(Path(folder) / asset, (Path(folder) / "SHA256SUMS.txt").read_text())
    content, versions = re.subn(r'^  version "[^"]+"$', f'  version "{version}"', content, count=1, flags=re.MULTILINE)
    content, hashes = re.subn(r'^  sha256 "[^"]+"$', f'  sha256 "{digest}"', content, count=1, flags=re.MULTILINE)
    if versions != 1 or hashes != 1:
        raise ValueError("Unexpected cask format")
    CASK.write_text(content)
    print(f"Updated find-yoshi-it to {version}")


if __name__ == "__main__":
    main()
