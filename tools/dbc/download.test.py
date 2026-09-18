"""Source artifact download tests; all network responses and files are fixtures."""
import hashlib
import io
import json
import lzma
from pathlib import Path
import sqlite3
import tempfile
import unittest
from unittest.mock import patch

import download

OLD = "1.15.9.69722"
NEW = "1.60.1.69893"


class DownloadTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.path = self.root / "cache/dbc-source.db"
        fixture = self.root / "fixture.db"
        conn = sqlite3.connect(fixture)
        conn.execute("CREATE TABLE _build (build TEXT)")
        conn.executemany("INSERT INTO _build VALUES (?)", [(OLD,), (NEW,)])
        for table in ("_table_build", "ui_map", "ui_map_assignment", "area_table"):
            conn.execute("CREATE TABLE %s (ID)" % table)
        conn.commit()
        conn.close()
        self.database = fixture.read_bytes()
        self.archive = lzma.compress(self.database)
        self.release = {
            "tag_name": "vfixture",
            "assets": [
                {"name": "manifest.json", "browser_download_url": "https://fixture/manifest"},
                {"name": "dbc-source.db.xz", "browser_download_url": "https://fixture/source"},
            ],
        }
        self.manifest = {"tag": "vfixture", "artifacts": {"source": {
            "filename": "dbc-source.db.xz", "sha256": hashlib.sha256(self.archive).hexdigest(),
        }}}
        self.requests = []
        transport = patch.object(download, "should_use_gh", return_value=False)
        self.addCleanup(transport.stop)
        transport.start()

    def response(self, url):
        self.requests.append(url)
        payloads = {
            download.API + "latest": json.dumps(self.release).encode(),
            download.API + "tags/vfixture": json.dumps(self.release).encode(),
            "https://fixture/manifest": json.dumps(self.manifest).encode(),
            "https://fixture/source": self.archive,
        }
        return io.BytesIO(payloads[url])

    def install(self, **kwargs):
        with patch.object(download, "open_url", side_effect=self.response):
            return download.ensure_database(self.path, OLD, NEW, **kwargs)

    def test_existing_database_never_contacts_network(self):
        self.path.parent.mkdir()
        self.path.write_bytes(self.database)
        with patch.object(download, "open_url") as network:
            result = download.ensure_database(self.path, OLD, NEW)
        network.assert_not_called()
        self.assertEqual(result["origin"], "existing-local")
        self.assertEqual(self.path.read_bytes(), self.database)

    def test_download_is_pinned_verified_and_installed(self):
        result = self.install()
        self.assertEqual(self.path.read_bytes(), self.database)
        self.assertEqual(result["release_tag"], "vfixture")
        self.assertEqual(result["artifact_sha256"], hashlib.sha256(self.archive).hexdigest())
        self.assertEqual(self.requests, [download.API + "latest", "https://fixture/manifest", "https://fixture/source"])
        self.assertEqual(list(self.path.parent.iterdir()), [self.path])

    def test_explicit_release_tag_is_used(self):
        self.install(tag="vfixture")
        self.assertEqual(self.requests[0], download.API + "tags/vfixture")

    def test_checksum_failure_leaves_no_final_or_partial_database(self):
        self.manifest["artifacts"]["source"]["sha256"] = "0" * 64
        with self.assertRaisesRegex(ValueError, "SHA-256 mismatch"):
            self.install()
        self.assertFalse(self.path.exists())
        self.assertEqual(list(self.path.parent.iterdir()), [])

    def test_invalid_compression_leaves_no_final_database(self):
        self.archive = b"not an xz file"
        self.manifest["artifacts"]["source"]["sha256"] = hashlib.sha256(self.archive).hexdigest()
        with self.assertRaisesRegex(ValueError, "Invalid compressed"):
            self.install()
        self.assertFalse(self.path.exists())
        self.assertEqual(list(self.path.parent.iterdir()), [])

    def test_download_missing_required_build_is_not_installed(self):
        with patch.object(download, "open_url", side_effect=self.response), self.assertRaisesRegex(ValueError, "required build"):
            download.ensure_database(self.path, OLD, "1.60.1.99999")
        self.assertFalse(self.path.exists())

    def test_existing_corruption_is_not_replaced(self):
        self.path.parent.mkdir()
        self.path.write_bytes(b"do not replace")
        with patch.object(download, "open_url") as network, self.assertRaisesRegex(ValueError, "Not a SQLite"):
            download.ensure_database(self.path, OLD, NEW)
        network.assert_not_called()
        self.assertEqual(self.path.read_bytes(), b"do not replace")

    def test_manifest_cannot_switch_to_a_different_release(self):
        self.manifest["tag"] = "different"
        with self.assertRaisesRegex(ValueError, "manifest tag differs"):
            self.install()
        self.assertFalse(self.path.exists())

    def test_symlinked_cache_is_refused_without_network(self):
        try:
            self.path.parent.symlink_to(self.root, target_is_directory=True)
        except OSError:
            self.skipTest("Symlink creation unavailable")
        with patch.object(download, "open_url") as network, self.assertRaisesRegex(ValueError, "symlinked"):
            download.ensure_database(self.path, OLD, NEW)
        network.assert_not_called()

    def test_authenticated_download_uses_one_release_and_verifies_the_same_artifact(self):
        commands = []

        def authenticated(arguments, capture=False):
            commands.append(arguments)
            if arguments[0] == "api":
                return json.dumps(self.release)
            filename = arguments[arguments.index("--pattern") + 1]
            self.assertEqual(arguments[-2:], ["--", "vfixture"])
            if filename == "manifest.json":
                self.assertTrue(capture)
                return json.dumps(self.manifest)
            self.assertFalse(capture)
            Path(arguments[arguments.index("--output") + 1]).write_bytes(self.archive)
            return ""

        with patch.object(download, "should_use_gh", return_value=True), \
                patch.object(download, "gh", side_effect=authenticated), patch.object(download, "open_url") as public:
            result = download.ensure_database(self.path, OLD, NEW)
        public.assert_not_called()
        self.assertEqual(len(commands), 3)
        self.assertEqual(result["artifact_sha256"], hashlib.sha256(self.archive).hexdigest())
        self.assertEqual(self.path.read_bytes(), self.database)

    def test_concurrent_install_is_not_overwritten(self):
        original_validate = download.validate_database

        def validate_and_race(path, source, target):
            original_validate(path, source, target)
            self.path.write_bytes(b"concurrent install")

        with patch.object(download, "validate_database", side_effect=validate_and_race), self.assertRaises(FileExistsError):
            self.install()
        self.assertEqual(self.path.read_bytes(), b"concurrent install")


if __name__ == "__main__":
    unittest.main()
