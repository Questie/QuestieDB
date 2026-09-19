"""Portable packaging tests, using only disposable tiny inputs.

Run: uv run tools/distribution/package.test.py
No generated checkout artifacts, Questie inputs, network, or installed addons are used.
"""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest
import zipfile
from unittest.mock import patch


ROOT = Path(__file__).resolve().parents[2]
FLAVORS = ("Vanilla", "TBC", "Wrath", "Cata", "Mists")
PIN = "a" * 40
SPEC = importlib.util.spec_from_file_location("questiedb_package", ROOT / "tools/distribution/package.py")
packager = importlib.util.module_from_spec(SPEC)
sys.modules[SPEC.name] = packager
SPEC.loader.exec_module(packager)
try:
    LUA = packager.find_lua()
except ValueError:
    LUA = None


class LuaSelectionTest(unittest.TestCase):
    def test_bundle_matches_platform_and_explicit_override_wins(self):
        with tempfile.TemporaryDirectory(prefix="package Lua ") as directory:
            root = Path(directory)
            cases = [("win32", "AMD64", "", root / "tools/lua-binary/lua.exe"),
                     ("win32", "x86", "", root / "lua5.1"),
                     ("win32", "ARM64", "", root / "lua5.1"),
                     ("linux", "x86_64", "", root / "tools/lua-binary/linux-x64/lua"),
                     ("linux", "aarch64", "", root / "lua5.1"),
                     ("darwin", "arm64", "", root / "lua5.1"),
                     ("win32", "AMD64", "custom", root / "custom"),
                     ("linux", "x86_64", "custom", root / "custom")]
            for platform, machine, override, expected in cases:
                with self.subTest(platform=platform, machine=machine, override=override), \
                        patch.object(packager, "ROOT", root), \
                        patch.object(packager.sys, "platform", platform), \
                        patch.object(packager.platform, "machine", return_value=machine), \
                        patch.dict(os.environ, {"LUA": override}), \
                        patch.object(packager.shutil, "which", side_effect=lambda name: str(root / name)), \
                        patch.object(packager.subprocess, "run", return_value=subprocess.CompletedProcess(
                            [], 0, stdout="Lua 5.1", stderr="")) as run:
                    self.assertEqual(str(expected.resolve()), packager.find_lua())
                    self.assertEqual(str(expected), run.call_args.args[0][0])
            with patch.dict(os.environ, {"LUA": "missing-override"}), \
                    patch.object(packager.sys, "platform", "win32"), \
                    patch.object(packager.shutil, "which", return_value=None), \
                    self.assertRaisesRegex(ValueError, "Lua 5.1 is required"):
                packager.find_lua()


@unittest.skipUnless(shutil.which("git"), "Git is required for changelog fixtures")
class ChangelogTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb changelog ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.git("init", "--quiet")
        self.git("config", "user.name", "Release test")
        self.git("config", "user.email", "release@example.invalid")
        self.git("config", "commit.gpgsign", "false")
        self.git("config", "tag.gpgsign", "false")
        self.url = "https://github.com/Questie/QuestieDB"

    def git(self, *args):
        return subprocess.run(["git", "-C", str(self.root), *args], check=True,
                              capture_output=True, text=True, encoding="utf-8").stdout.strip()

    def commit(self, subject):
        self.git("-c", "core.hooksPath=", "commit", "--quiet", "--allow-empty", "-m", subject)
        return self.git("rev-parse", "HEAD")

    def notes(self, version="1.2.3-dev.abcdef0"):
        return packager.release_notes.changelog(self.root, version, self.git("rev-parse", "HEAD"), self.url)

    def test_questie_prefixes_group_sort_and_preserve_authored_text(self):
        for subject in ("[fix] Zed", "[FEATURE] Added a feature", "[Fix] Alpha [fix] stays",
                        "[quest] Quest change", "[db] Database change", "[locale]Translation change",
                        "[fix]   ", "[other] Not included", "fix: Not included",
                        "Some [fix] Not included", "Internal change\n\n[fix] Body is not a subject"):
            self.commit(subject)
        notes = self.notes()
        headings = ["New features", "General fixes", "Quest fixes", "Database fixes", "Localization fixes"]
        self.assertEqual(sorted(notes.index("### " + heading) for heading in headings),
                         [notes.index("### " + heading) for heading in headings])
        self.assertIn("- Alpha [fix] stays\n- Zed", notes)
        self.assertIn("- Translation change", notes)
        self.assertIn("- Added a feature", notes)
        self.assertNotIn("Not included", notes)
        self.assertNotIn("Body is not", notes)
        self.assertEqual(6, notes.count("\n- "))

    def test_stable_boundary_preview_and_override_with_mixed_tags(self):
        old = self.commit("[fix] Old fix")
        self.git("tag", "v1.9.0")
        self.commit("[fix] Already released")
        self.git("tag", "-a", "v1.10.0", "-m", "Stable release")
        self.commit("[db] New data")
        for tag in ("preview", "build-123", "v2.0.0-beta", "v01.20.0"):
            self.git("tag", tag)
        self.commit("[fix] New fix")
        self.git("tag", "v1.11.0")
        head = self.commit("[locale] New translation")
        # An unreachable higher version must not hide changes from this release line.
        self.git("checkout", "--detach", old)
        self.commit("[fix] Unrelated branch")
        self.git("tag", "v99.0.0")
        self.git("checkout", "--detach", head)

        stable = self.notes("1.11.0")
        self.assertIn("- New data", stable)
        self.assertIn("- New fix", stable)
        self.assertIn("- New translation", stable)
        self.assertIn(f"/compare/v1.10.0..{head}", stable)
        self.assertNotIn("Already released", stable)
        self.assertNotIn("Old fix", stable)
        self.assertNotIn("Unrelated branch", stable)

        preview = self.notes("1.11.0-dev.abcdef0")
        self.assertIn("- New translation", preview)
        self.assertIn(f"/compare/v1.11.0..{head}", preview)
        self.assertNotIn("- New fix", preview)
        self.assertNotIn("- New data", preview)

    def test_first_release_and_empty_selection_are_not_no_changes_claims(self):
        first = self.commit("[feature] First feature")
        self.git("tag", "preview")
        self.git("tag", "build-123")
        self.assertIn("- First feature", self.notes())
        self.assertIn(f"/commits/{first}", self.notes())
        self.git("tag", "v1.0.0")
        self.commit("Internal change")
        notes = self.notes()
        self.assertIn("No changelog entries were marked", notes)
        self.assertIn("/compare/v1.0.0..", notes)
        self.assertNotIn("###", notes)

    def test_shallow_checkout_does_not_present_partial_history_as_complete(self):
        self.commit("[fix] Older change")
        self.git("tag", "v1.0.0")
        head = self.commit("[fix] New change")
        with tempfile.TemporaryDirectory(prefix="questiedb shallow ") as directory:
            clone = Path(directory) / "clone"
            subprocess.run(["git", "clone", "--quiet", "--depth=1", self.root.as_uri(), str(clone)],
                           check=True, capture_output=True)
            notes = packager.release_notes.changelog(clone, "1.1.0", head, self.url)
        self.assertIn("shallow Git history", notes)
        self.assertIn(f"/commits/{head}", notes)
        self.assertNotIn("- New change", notes)


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
        for filename in ("package.py", "release_notes.py"):
            shutil.copy(ROOT / "tools/distribution" / filename, self.root / "tools/distribution" / filename)
        (self.root / "src").mkdir()
        shutil.copy(ROOT / "src/config.lua", self.root / "src" / "config.lua")
        self.write("src/types/Quest.t.lua", "---@meta _\n")
        self.write("src/types/General.t.lua", "---@meta _\n")
        self.write("src/types/consumer.test.lua", "-- not shipped\n")
        self.write("src/runtime.lua", "return 'shared runtime'\n")
        (self.root / "icons").mkdir()
        shutil.copyfile(ROOT / "icons/QuestieTDB_64x64.png", self.root / "icons/QuestieTDB_64x64.png")
        self.write("icons/QuestieTDB.pdn", "unshipped artwork\n")
        self.write("src/corrections/Era/fixes.lua", "return 'unstripped'\n")
        self.write("data/raw.lua", "-- source-only data\n")
        self.write("l10n/translation.lua", "-- source-only localization\n")
        self.write("QuestieDB.toc", "-- source-only TOC\n")
        self.write("tools/lua-binary/lua.exe", "contributor-only executable\n")
        self.write("tools/lua-binary/linux-x64/lua", "contributor-only executable\n")
        self.write("generate.cmd", "contributor-only launcher\n")
        # Only the stripper is substituted: the packager still invokes real Lua on staged
        # files. Production stripping has its own behavior-parity checks.
        shutil.copyfile(ROOT / "tools/distribution/fixtures/strip-static.lua",
                        self.root / "tools/distribution/strip-static.lua")
        for flavor in FLAVORS:
            self.write("support/%s.lua" % flavor, "return '%s'\n" % flavor)
            self.write("QuestieDB_%s.toc" % flavor,
                       "## X-QUESTIE-COMMIT: %s\n" % PIN +
                       "## Version: 1.2.3-dev.abcdef0\n## X-Contract-Version: 2\n" +
                       "## IconTexture: Interface\\AddOns\\QuestieDB\\icons\\QuestieTDB_64x64.png\n" +
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
                            "QuestieDB/Types/Quest.t.lua", "QuestieDB/Types/General.t.lua",
                            "QuestieDB/icons/QuestieTDB_64x64.png"}
                expected.update("QuestieDB/QuestieDB_%s.toc" % f for f in flavors)
                expected.update("QuestieDB/support/%s.lua" % f for f in flavors)
                self.assertEqual(expected, names)
                self.assertEqual((self.root / "src/config.lua").read_bytes(), archive.read("QuestieDB/src/config.lua"))
                self.assertEqual((self.root / "icons/QuestieTDB_64x64.png").read_bytes(),
                                 archive.read("QuestieDB/icons/QuestieTDB_64x64.png"))
                self.assertEqual(b"return 'dynamic only'\n", archive.read("QuestieDB/src/corrections/Era/fixes.lua"))
                for name in names:
                    self.assertEqual(zipfile.ZIP_DEFLATED, archive.getinfo(name).compress_type)
                if entry["flavor"] == "All":
                    self.assertEqual(union, names)
                else:
                    union.update(names)
        self.assertEqual("return 'unstripped'\n", (self.root / "src/corrections/Era/fixes.lua").read_text())
        self.assertFalse((self.root / ".out/stage").exists())
        notes = (dist / "RELEASE_NOTES.md").read_text()
        self.assertTrue(notes.startswith("# Unstable Pre-Release Build\n\n> [!WARNING]"))
        self.assertEqual(2, notes.count("> [!WARNING]"))
        self.assertIn("**Recommended: [QuestieDB-all.zip]", notes)
        self.assertIn("/releases/download/preview/QuestieDB-all.zip", notes)
        self.assertIn("Interface/AddOns/QuestieDB/QuestieDB_<Flavor>.toc", notes)
        self.assertIn("GitHub's **Source code** archives are not the packaged addon", notes)
        self.assertIn("<summary>Build details and checksums</summary>", notes)
        self.assertIn("Supported API contracts: `1` to `2`", notes)
        self.assertIn("without Git history", notes)
        self.assertLess(notes.index("</details>"), notes.rindex("> [!WARNING]"))
        self.assertTrue(notes.rstrip().endswith("/releases/latest)."))

    def test_single_flavor_package(self):
        result = self.run_package("Vanilla")
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual(["QuestieDB-Vanilla.zip"],
                         [p.name for p in (self.root / ".out/dist").glob("*.zip")])
        notes = (self.root / ".out/dist/RELEASE_NOTES.md").read_text()
        self.assertIn("[QuestieDB-Vanilla.zip]", notes)
        self.assertNotIn("QuestieDB-all.zip", notes)
        self.assertNotIn("QuestieDB-Mists.zip", notes)

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

    def test_missing_icon_preserves_previous_output(self):
        self.preserve_previous_output()
        (self.root / "icons/QuestieTDB_64x64.png").unlink()
        result = self.run_package("Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("QuestieTDB_64x64.png", result.stderr)
        self.assert_previous_output()

    def test_icon_path_cannot_escape_addon(self):
        self.preserve_previous_output()
        toc = self.root / "QuestieDB_Vanilla.toc"
        toc.write_text(toc.read_text().replace("icons\\QuestieTDB_64x64.png", "..\\outside.png"))
        result = self.run_package("Vanilla")
        self.assertNotEqual(0, result.returncode)
        self.assertIn("unsafe runtime path", result.stderr)
        self.assert_previous_output()

    def test_full_release_uses_baked_version_not_source_version(self):
        toc = self.root / "QuestieDB_Vanilla.toc"
        toc.write_text(toc.read_text().replace("1.2.3-dev.abcdef0", "1.2.3"))
        self.write("QuestieDB.toc", "## Version: 9.9.9\n")
        result = self.run_package("Vanilla")
        self.assertEqual(0, result.returncode, result.stderr)
        manifest = json.loads((self.root / ".out/dist/release.json").read_text())
        self.assertEqual("1.2.3", manifest["version"])
        notes = (self.root / ".out/dist/RELEASE_NOTES.md").read_text()
        self.assertTrue(notes.startswith("# QuestieDB 1.2.3\n"))
        self.assertIn("/releases/download/v1.2.3/QuestieDB-Vanilla.zip", notes)
        self.assertNotIn("[!WARNING]", notes)
        self.assertNotIn("Unstable", notes)
        self.assertNotIn("9.9.9", notes)

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

    def test_invalid_runtime_config_preserves_previous_output(self):
        # test.lua's contract-config suite covers every rejected value; packaging only has to
        # prove that a configuration that fails to load aborts before output is cleared.
        self.preserve_previous_output()
        path = self.root / "src/config.lua"
        path.write_text(path.read_text().replace("config.minSupportedContract = 1", "config.minSupportedContract = 3"))
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
