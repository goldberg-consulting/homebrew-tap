#!/usr/bin/env python3
"""CI-only: install an earlier release, upgrade, and verify library retention."""
import os
from pathlib import Path
import plistlib
import re
import subprocess

if os.environ.get("GITHUB_ACTIONS") != "true":
    raise SystemExit("Run only on a disposable GitHub Actions runner")


def run(*args):
    subprocess.run(args, check=True)


tap = Path(subprocess.check_output(["brew", "--repository", "goldberg-consulting/tap"], text=True).strip())
cask = tap / "Casks/find-yoshi-it.rb"
latest = cask.read_text()
expected = re.search(r'  version "([^"]+)"', latest).group(1)
temporary = Path(os.environ["RUNNER_TEMP"])
previous = temporary / "previous"
previous.mkdir()
run("gh", "release", "download", "v0.1.2", "--repo", "goldberg-consulting/find-yoshi-it",
    "--pattern", "SHA256SUMS.txt", "--dir", str(previous))
checksum = re.search(r"^([a-f0-9]{64})\s+Find-Yoshi-IT-v0\.1\.2-macOS-arm64\.zip$",
                     (previous / "SHA256SUMS.txt").read_text(), re.MULTILINE).group(1)
legacy = re.sub(r'  version "[^"]+"', '  version "0.1.2"', latest, count=1)
legacy = re.sub(r'  sha256 "[^"]+"', f'  sha256 "{checksum}"', legacy, count=1)
apps = temporary / "apps"
apps.mkdir()
try:
    cask.write_text(legacy)
    run("brew", "install", "--cask", f"--appdir={apps}", "goldberg-consulting/tap/find-yoshi-it")
finally:
    cask.write_text(latest)
library = Path.home() / "Library/Application Support/FindAnything"
library.mkdir(parents=True, exist_ok=True)
marker = library / "homebrew-upgrade-test"
marker.write_text("retain existing index")
run("brew", "upgrade", "--cask", "goldberg-consulting/tap/find-yoshi-it")
app = apps / "Find Yoshi IT.app"
with (app / "Contents/Info.plist").open("rb") as stream:
    assert plistlib.load(stream)["CFBundleShortVersionString"] == expected
run("codesign", "--verify", "--deep", "--strict", str(app))
assert marker.read_text() == "retain existing index"
run("brew", "uninstall", "--cask", "--zap", "goldberg-consulting/tap/find-yoshi-it")
assert marker.read_text() == "retain existing index"
print(f"Installation, upgrade from 0.1.2 to {expected}, signature, and library retention passed.")
