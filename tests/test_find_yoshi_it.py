import hashlib
import importlib.util
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location("updater", Path(__file__).resolve().parents[1] / "scripts/update-find-yoshi-it.py")
updater = importlib.util.module_from_spec(spec)
spec.loader.exec_module(updater)


class UpdateTests(unittest.TestCase):
    def release(self):
        return {"tag_name": "v0.1.4", "draft": False, "prerelease": False, "assets": [
            {"name": "Find-Yoshi-IT-v0.1.4-macOS-arm64.zip", "state": "uploaded", "size": 42},
            {"name": "SHA256SUMS.txt", "state": "uploaded", "size": 100}]}

    def test_stable_complete_release(self):
        self.assertEqual(updater.release_asset(self.release())[0], "0.1.4")
        self.assertGreater(updater.version_tuple("0.1.10"), updater.version_tuple("0.1.9"))

    def test_unfinished_releases_cannot_advance_tap(self):
        for mutation in ({"draft": True}, {"prerelease": True}, {"tag_name": "v0.1.4-rc1"}, {"assets": []}):
            with self.assertRaises(ValueError):
                updater.release_asset(self.release() | mutation)

    def test_checksum_must_match_exact_asset(self):
        with tempfile.TemporaryDirectory() as folder:
            archive = Path(folder) / "release.zip"
            archive.write_bytes(b"fixture")
            digest = hashlib.sha256(b"fixture").hexdigest()
            good = f"{digest}  release.zip\n"
            self.assertEqual(updater.verify_checksum(archive, good), digest)
            for invalid in (f"{digest}  other.zip\n", "0" * 64 + "  release.zip\n", good + good):
                with self.assertRaises(ValueError):
                    updater.verify_checksum(archive, invalid)


if __name__ == "__main__":
    unittest.main()
