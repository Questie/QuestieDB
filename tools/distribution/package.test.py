"""Portable packaging tests, using only disposable tiny inputs.

Run: uv run tools/distribution/package.test.py
No generated checkout artifacts, Questie inputs, network, or installed addons are used.
"""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest
import zipfile


ROOT = Path(__file__).resolve().parents[2]
FLAVORS = ("Vanilla", "TBC", "Wrath", "Cata", "Mists")
PIN = "a" * 40
LUA = None
for name in ([os.environ["LUA"]] if os.environ.get("LUA") else ["lua5.1", "lua"]):
    candidate = shutil.which(name)
    if candidate:
        result = subprocess.run([candidate, "-e", "io.write(_VERSION)"], capture_output=True, text=True)
        if result.returncode == 0 and result.stdout == "Lua 5.1":
            LUA = candidate
            break


class PackageTest(unittest.TestCase):
    def setUp(self):
        if not LUA:
            self.skipTest("Lua 5.1 is required for the packaging fixture")
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb package ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.bin = self.root / "bin"
        self.bin.mkdir()
        # Python and Lua are explicit: no external ZIP, checksum, Git, or shell tools.
        (self.root / "tools/distribution").mkdir(parents=True)
        shutil.copy(ROOT / "tools/distribution/package.py", self.root / "tools/distribution/package.py")
        (self.root / "src").mkdir()
        shutil.copy(ROOT / "src/config.lua", self.root / "src" / "config.lua")
        self.write("src/types/Quest.t.lua", "---@meta _\n")
        self.write("src/types/General.t.lua", "---@meta _\n")
        self.write("src/types/consumer.test.lua", "-- not shipped\n")
        self.write("src/runtime.lua", "return 'shared runtime'\n")
        self.write("src/corrections/Era/fixes.lua", "return 'unstripped'\n")
        self.write("data/raw.lua", "-- source-only data\n")
        self.write("l10n/translation.lua", "-- source-only localization\n")
        self.write("QuestieDB.toc", "-- source-only TOC\n")
        # Only the stripper is substituted: the packager still invokes real Lua on staged
        # files. Production stripping has its own behavior-parity checks.
        shutil.copyfile(ROOT / "tools/distribution/fixtures/strip-static.lua",
                        self.root / "tools/distribution/strip-static.lua")
        for flavor in FLAVORS:
            self.write("support/%s.lua" % flavor, "return '%s'\n" % flavor)
            self.write("QuestieDB_%s.toc" % flavor,
                       "## X-QUESTIE-COMMIT: %s\n" % PIN +
                       "## Version: 1.2.3-dev.abcdef0\n## X-Contract-Version: 2\n" +
                       "src\\config.lua\nsrc\\runtime.lua\nsrc\\corrections\\Era\\fixes.lua\n" +
                       "support\\%s.lua\n" % flavor + "## X-Quest-1-S: fixture\n")
        self.env = dict(os.environ, PATH=str(self.bin), LUA=LUA, SOURCE_DATE_EPOCH="1700000000",
                        QUESTIEDB_TEST_FAIL_STRIP="0")
        self.env.pop("QUESTIE_COMMIT", None)

    def write(self, relative, content):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content.encode("utf-8"))

    def run_package(self, *flavors):
        command = [sys.executable, str(self.root / "tools/distribution/package.py"), *flavors]
        return subprocess.run(command, cwd=self.bin, env=self.env,
                              capture_output=True, text=True, timeout=30)

    def preserve_previous_output(self):
        self.write(".out/dist/previous.zip", "previous package")
        self.write(".out/stage/previous.txt", "previous stage")

    def assert_previous_output(self):
        self.assertEqual("previous package", (self.root / ".out/dist/previous.zip").read_text())
        self.assertEqual("previous stage", (self.root / ".out/stage/previous.txt").read_text())

    def test_all_archives_preserve_union_types_stripping_and_manifest(self):
        result = self.run_package("all")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        dist = self.root / ".out/dist"
        manifest = json.loads((dist / "release.json").read_text())
        self.assertEqual("0" * 40, manifest["producerCommit"])
        self.assertEqual(PIN, manifest["questieCommit"])
        self.assertEqual(2, manifest["contractVersion"])
        self.assertEqual(1, manifest["minSupportedContract"])
        self.assertEqual("1.2.3-dev.abcdef0", manifest["version"])
        self.assertEqual("2023-11-14T22:13:20Z", manifest["builtAt"])
        self.assertIs(manifest["nolib"], False)
        self.assertEqual([*FLAVORS, "All"], [entry["flavor"] for entry in manifest["artifacts"]])
        union = set()
        for entry in manifest["artifacts"]:
            archive_path = dist / entry["file"]
            self.assertEqual(hashlib.sha256(archive_path.read_bytes()).hexdigest(), entry["sha256"])
            self.assertEqual(archive_path.stat().st_size, entry["bytes"])
            flavors = FLAVORS if entry["flavor"] == "All" else (entry["flavor"],)
            self.assertEqual(sum((self.root / ("QuestieDB_%s.toc" % f)).stat().st_size for f in flavors),
                             entry["rawBytes"])
            with zipfile.ZipFile(archive_path) as archive:
                self.assertIsNone(archive.testzip())
                names = {info.filename for info in archive.infolist() if not info.is_dir()}
                expected = {"QuestieDB/src/config.lua", "QuestieDB/src/runtime.lua", "QuestieDB/src/corrections/Era/fixes.lua",
                            "QuestieDB/Types/Quest.t.lua", "QuestieDB/Types/General.t.lua"}
                expected.update("QuestieDB/QuestieDB_%s.toc" % f for f in flavors)
                expected.update("QuestieDB/support/%s.lua" % f for f in flavors)
                self.assertEqual(expected, names)
                self.assertEqual((self.root / "src/config.lua").read_bytes(), archive.read("QuestieDB/src/config.lua"))
                self.assertEqual(b"return 'dynamic only'\n", archive.read("QuestieDB/src/corrections/Era/fixes.lua"))
                for name in names:
                    self.assertEqual(zipfile.ZIP_DEFLATED, archive.getinfo(name).compress_type)
                if entry["flavor"] == "All":
                    self.assertEqual(union, names)
                else:
                    union.update(names)
        self.assertEqual("return 'unstripped'\n", (self.root / "src/corrections/Era/fixes.lua").read_text())
        self.assertFalse((self.root / ".out/stage").exists())
        self.assertTrue((dist / "RELEASE_NOTES.md").is_file())

    def test_single_flavor_package(self):
        result = self.run_package("Vanilla")
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual(["QuestieDB-Vanilla.zip"],
                         [p.name for p in (self.root / ".out/dist").glob("*.zip")])

    def test_missing_lua_preserves_previous_output(self):
        self.preserve_previous_output()
        self.env["LUA"] = str(self.root / "missing-lua")
        result = self.run_package("all")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("Lua 5.1 is required", result.stderr)
        self.assert_previous_output()

    def test_missing_requested_flavor_preserves_previous_output(self):
        self.preserve_previous_output()
        (self.root / "QuestieDB_Mists.toc").unlink()
        result = self.run_package("all")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("QuestieDB_Mists.toc is not generated", result.stderr)
        self.assert_previous_output()

    def test_mixed_baselines_preserve_previous_output(self):
        self.preserve_previous_output()
        toc = self.root / "QuestieDB_Mists.toc"
        toc.write_text(toc.read_text().replace(PIN, "b" * 40))
        result = self.run_package("all")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("different legacy Questie baselines", result.stderr)
        self.assert_previous_output()

    def test_missing_runtime_file_preserves_previous_output(self):
        self.preserve_previous_output()
        (self.root / "src/runtime.lua").unlink()
        result = self.run_package("Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("missing runtime file", result.stderr)
        self.assert_previous_output()

    def test_full_release_uses_baked_version_not_source_version(self):
        toc = self.root / "QuestieDB_Vanilla.toc"
        toc.write_text(toc.read_text().replace("1.2.3-dev.abcdef0", "1.2.3"))
        self.write("QuestieDB.toc", "## Version: 9.9.9\n")
        result = self.run_package("Vanilla")
        self.assertEqual(0, result.returncode, result.stderr)
        manifest = json.loads((self.root / ".out/dist/release.json").read_text())
        self.assertEqual("1.2.3", manifest["version"])

    def test_manifest_tracks_supported_floor_from_runtime_configuration(self):
        path = self.root / "src/config.lua"
        path.write_text(path.read_text().replace("config.minSupportedContract = 1", "config.minSupportedContract = 2"))
        result = self.run_package("Vanilla")
        self.assertEqual(0, result.returncode, result.stderr)
        manifest = json.loads((self.root / ".out/dist/release.json").read_text())
        self.assertEqual(2, manifest["minSupportedContract"])
        self.assertEqual(2, manifest["contractVersion"])

    def test_mixed_versions_preserve_previous_output(self):
        self.preserve_previous_output()
        toc = self.root / "QuestieDB_Mists.toc"
        toc.write_text(toc.read_text().replace("1.2.3-dev.abcdef0", "1.2.4"))
        result = self.run_package("all")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("different addon versions", result.stderr)
        self.assert_previous_output()

    def test_toc_contract_must_match_shipped_runtime(self):
        self.preserve_previous_output()
        toc = self.root / "QuestieDB_Vanilla.toc"
        toc.write_text(toc.read_text().replace("X-Contract-Version: 2", "X-Contract-Version: 3"))
        result = self.run_package("Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("differs from the packaged runtime", result.stderr)
        self.assert_previous_output()

    def test_missing_runtime_config_preserves_previous_output(self):
        self.preserve_previous_output()
        toc = self.root / "QuestieDB_Vanilla.toc"
        toc.write_text(toc.read_text().replace("src\\config.lua\n", ""))
        result = self.run_package("Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("must load src/config.lua", result.stderr)
        self.assert_previous_output()

    def test_invalid_or_duplicate_toc_metadata_preserves_previous_output(self):
        toc = self.root / "QuestieDB_Vanilla.toc"
        original = toc.read_text()
        for header in ("## Version: 01.2.3", "## Version:", "## Version: 1.2.3-dev.preview",
                       "## Version: 1.2.3\n## version: 1.2.3", "## X-Contract-Version: 0",
                       "## X-Contract-Version: 1.5", "## X-Contract-Version: 2\n## x-contract-version: 2"):
            with self.subTest(header=header):
                self.preserve_previous_output()
                lines = original.splitlines()
                key = header.split(":", 1)[0]
                toc.write_text("\n".join(header if line.startswith(key + ":") else line for line in lines) + "\n")
                result = self.run_package("Vanilla")
                self.assertNotEqual(0, result.returncode, result.stdout)
                self.assert_previous_output()

    def test_invalid_runtime_ranges_preserve_previous_output(self):
        path = self.root / "src/config.lua"
        original = path.read_text()
        for replacement in ("0", "1.5", '"1"', "nil", "0/0", "math.huge", "3"):
            with self.subTest(minimum=replacement):
                self.preserve_previous_output()
                path.write_text(original.replace("config.minSupportedContract = 1",
                                                "config.minSupportedContract = " + replacement))
                result = self.run_package("Vanilla")
                self.assertNotEqual(0, result.returncode)
                self.assertIn("minSupportedContract", result.stderr)
                self.assert_previous_output()

    def test_stripping_failure_cannot_produce_a_manifest(self):
        self.env["QUESTIEDB_TEST_FAIL_STRIP"] = "1"
        result = self.run_package("Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertFalse((self.root / ".out/dist/release.json").exists())



if __name__ == "__main__":
    unittest.main()
