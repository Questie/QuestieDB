"""Bootstrap tests use in-memory release assets and disposable AddOns directories only.

Run: uv run tools/distribution/bootstrap.test.py
"""

import contextlib
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import stat
import tempfile
import unittest
import warnings
from unittest.mock import patch
import zipfile


TOOLS = Path(__file__).resolve().parent
SPEC = importlib.util.spec_from_file_location("bootstrap", TOOLS / "bootstrap.py")
bootstrap = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(bootstrap)


def archive_bytes(flavors, extra=None):
    output = io.BytesIO()
    with zipfile.ZipFile(output, "w", zipfile.ZIP_DEFLATED) as archive:
        for flavor in flavors:
            archive.writestr("QuestieDB/QuestieDB_%s.toc" % flavor, "## X-Mode: baked\n")
        archive.writestr("QuestieDB/src/runtime.lua", "return 'shared'\n")
        archive.writestr("QuestieDB/Types/Quest.t.lua", "---@meta _\n")
        for name, value in (extra or {}).items():
            archive.writestr(name, value)
    return output.getvalue()


class BootstrapTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb bootstrap ")
        self.addCleanup(self.temp.cleanup)
        self.addons = Path(self.temp.name) / "Interface" / "AddOns"
        self.target = self.addons / "QuestieDB"

        # Model an existing clone: replace release files without losing unrelated work.
        (self.target / ".git").mkdir(parents=True)
        (self.target / ".git/config").write_text("developer clone")
        (self.target / "QuestieDB_Vanilla.toc").write_text("old artifact")
        (self.target / "QuestieDB_Obsolete.toc").write_text("old flavor")
        (self.target / "QuestieDB.toc").write_text("source mode")
        (self.target / "custom.lua").write_text("unrelated file")

        self.assets = {"QuestieDB-all.zip": archive_bytes(bootstrap.FLAVORS)}
        self.refresh_manifest()
        self.requests = []
        self.original = self.snapshot()

        self.addCleanup(patch.stopall)
        patch.object(bootstrap, "download", side_effect=self.download).start()

    def snapshot(self):
        return {
            str(path.relative_to(self.target)): path.read_bytes()
            for path in self.target.rglob("*")
            if path.is_file()
        }

    def refresh_manifest(self):
        manifest = {
            "producerCommit": "a" * 40,
            "contractVersion": 2,
            "artifacts": [
                {"file": name, "sha256": hashlib.sha256(data).hexdigest()}
                for name, data in self.assets.items()
                if name.endswith(".zip")
            ],
        }
        self.assets["release.json"] = json.dumps({"releases": [], "questiedb": manifest}).encode()

    def download(self, url, destination):
        self.requests.append(url)
        name = url.rsplit("/", 1)[-1]
        if name not in self.assets:
            raise OSError("missing download: " + name)
        destination.write_bytes(self.assets[name])

    def install(self, tag="latest", repo="Questie/QuestieDB"):
        with contextlib.redirect_stdout(io.StringIO()):
            return bootstrap.install(self.addons, tag, repo)

    def test_combined_archive_only_preserves_clone_and_removes_obsolete_tocs(self):
        self.assertEqual(self.target.resolve(), self.install())
        self.assertEqual(
            [
                "https://github.com/Questie/QuestieDB/releases/latest/download/release.json",
                "https://github.com/Questie/QuestieDB/releases/latest/download/QuestieDB-all.zip",
            ],
            self.requests,
        )
        self.assertEqual(
            bootstrap.TOCS, {path.name for path in self.target.glob("QuestieDB_*.toc")}
        )
        self.assertEqual("developer clone", (self.target / ".git/config").read_text())
        self.assertEqual("unrelated file", (self.target / "custom.lua").read_text())
        self.assertEqual("source mode", (self.target / "QuestieDB.toc").read_text())
        self.assertEqual("return 'shared'\n", (self.target / "src/runtime.lua").read_text())

    def test_hash_mismatch_leaves_install_unchanged(self):
        self.assets["QuestieDB-all.zip"] += b"corruption"
        with self.assertRaisesRegex(ValueError, "checksum mismatch"):
            self.install()
        self.assertEqual(self.original, self.snapshot())

    def test_missing_download_leaves_install_unchanged(self):
        del self.assets["QuestieDB-all.zip"]
        with self.assertRaisesRegex(OSError, "missing download"):
            self.install()
        self.assertEqual(self.original, self.snapshot())

    def test_verified_but_invalid_zip_leaves_install_unchanged(self):
        self.assets["QuestieDB-all.zip"] = b"not a ZIP"
        self.refresh_manifest()
        with self.assertRaises(zipfile.BadZipFile):
            self.install()
        self.assertEqual(self.original, self.snapshot())

    def test_incomplete_combined_archive_leaves_install_unchanged(self):
        self.assets["QuestieDB-all.zip"] = archive_bytes(["Vanilla"])
        self.refresh_manifest()
        with self.assertRaisesRegex(ValueError, "all five generated"):
            self.install()
        self.assertEqual(self.original, self.snapshot())

    def test_malformed_manifests_are_rejected_before_zip_download(self):
        cases = [
            [],
            {},
            {"questiedb": None},
            json.loads(self.assets["release.json"])["questiedb"],
            *(
                {"releases": [], "questiedb": metadata}
                for metadata in (
                    {},
                    {"artifacts": []},
                    {"artifacts": [None]},
                    {"artifacts": [{"file": "../payload.zip", "sha256": "a" * 64}]},
                    {"artifacts": [{"file": "https://elsewhere/payload.zip", "sha256": "a" * 64}]},
                    {"artifacts": [{"file": "QuestieDB-all.zip", "sha256": "bad"}]},
                    {"artifacts": [{"file": "QuestieDB-Vanilla.zip", "sha256": "a" * 64}]},
                    {"artifacts": [{"file": "QuestieDB-all.zip", "sha256": "a" * 64}] * 2},
                )
            ),
        ]
        for manifest in cases:
            with self.subTest(manifest=manifest):
                self.requests.clear()
                self.assets["release.json"] = json.dumps(manifest).encode()
                with self.assertRaises(ValueError):
                    self.install()
                self.assertEqual(1, len(self.requests))
                self.assertEqual(self.original, self.snapshot())

    def test_archive_paths_cannot_escape_or_overwrite_clone_metadata(self):
        for name in (
            "QuestieDB/../outside.lua",
            "/QuestieDB/src/file.lua",
            "QuestieDB/.git/config",
            "QuestieDB/src/.git/config",
            "QuestieDB/src\\outside.lua",
            "QuestieDB/src/file.lua:stream",
            "QuestieDB/src/NUL.lua",
            "QuestieDB/src/file.lua.",
            "QuestieDB/SRC/other.lua",
            "QuestieDB/icons/../outside.png",
            "QuestieDB/CHANGELOG.md/extra.lua",
            "QuestieDB/CHANGELOG.md.bak",
        ):
            with self.subTest(name=name):
                self.assets["QuestieDB-all.zip"] = archive_bytes(
                    bootstrap.FLAVORS, {name: "unsafe"}
                )
                self.refresh_manifest()
                with self.assertRaises(ValueError):
                    self.install()
                self.assertEqual(self.original, self.snapshot())

    def test_symlink_archive_entry_is_rejected(self):
        data = io.BytesIO(archive_bytes(bootstrap.FLAVORS))

        with zipfile.ZipFile(data, "a") as archive:
            link = zipfile.ZipInfo("QuestieDB/src/link.lua")
            link.create_system = 3
            link.external_attr = (stat.S_IFLNK | 0o777) << 16
            archive.writestr(link, "../../outside")

        self.assets["QuestieDB-all.zip"] = data.getvalue()
        self.refresh_manifest()
        with self.assertRaisesRegex(ValueError, "link or special file"):
            self.install()
        self.assertEqual(self.original, self.snapshot())

    def test_duplicate_archive_entries_are_rejected_before_installation(self):
        data = io.BytesIO(self.assets["QuestieDB-all.zip"])
        with warnings.catch_warnings():
            warnings.filterwarnings("ignore", message="Duplicate name:", category=UserWarning)
            with zipfile.ZipFile(data, "a") as archive:
                archive.writestr("QuestieDB/src/runtime.lua", "return 'different'\n")
        self.assets["QuestieDB-all.zip"] = data.getvalue()
        self.refresh_manifest()
        with self.assertRaisesRegex(ValueError, "duplicate archive entry"):
            self.install()
        self.assertEqual(self.original, self.snapshot())

    def test_existing_destination_symlink_is_not_followed(self):
        outside = Path(self.temp.name) / "outside"
        outside.mkdir()
        sentinel = outside / "runtime.lua"
        sentinel.write_text("do not overwrite")

        try:
            (self.target / "src").symlink_to(outside, target_is_directory=True)
        except OSError as error:
            self.skipTest("symlink creation unavailable: %s" % error)

        with self.assertRaisesRegex(ValueError, "traverses a link"):
            self.install()
        self.assertEqual("do not overwrite", sentinel.read_text())
        self.assertEqual(self.original, self.snapshot())

    def test_tags_are_quoted_and_repo_cannot_select_another_host(self):
        self.install("feature/test #1", "Owner/Repository")
        self.assertTrue(
            all(
                url.startswith(
                    "https://github.com/Owner/Repository/releases/download/feature%2Ftest%20%231/"
                )
                for url in self.requests
            )
        )
        self.requests.clear()
        with self.assertRaisesRegex(ValueError, "owner/name"):
            self.install(repo="https://example.com/repo")
        self.assertEqual([], self.requests)

    def test_main_honors_repo_environment_and_returns_failure_status(self):
        with patch.dict(
            os.environ, {"QUESTIEDB_REPO": "Owner/Repository"}
        ), contextlib.redirect_stdout(io.StringIO()):
            self.assertEqual(0, bootstrap.main([str(self.addons), "preview"]))
        self.assertTrue(all("github.com/Owner/Repository/" in url for url in self.requests))
        with contextlib.redirect_stderr(io.StringIO()):
            self.assertEqual(1, bootstrap.main([str(self.addons / "missing")]))


if __name__ == "__main__":
    unittest.main()
