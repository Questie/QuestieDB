"""Portable packaging tests, using only disposable tiny inputs.

Run: uv run tools/distribution/package.test.py
No generated checkout artifacts, Questie inputs, network, or installed addons are used.
"""

import contextlib
import hashlib
import importlib.util
import io
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

import bootstrap
import release_artifacts


ROOT = Path(__file__).resolve().parents[2]
FLAVORS = ("Vanilla", "TBC", "Wrath", "Cata", "Mists")
PIN = "a" * 40
CREDIT_FIXTURES = json.loads(
    (ROOT / "tools/distribution/fixtures/author-credits.json").read_text(encoding="utf-8")
)

SPEC = importlib.util.spec_from_file_location(
    "questiedb_package", ROOT / "tools/distribution/package.py"
)
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
            cases = [
                ("win32", "AMD64", "", root / "tools/lua-binary/lua.exe"),
                ("win32", "x86", "", root / "lua5.1"),
                ("win32", "ARM64", "", root / "lua5.1"),
                ("linux", "x86_64", "", root / "tools/lua-binary/linux-x64/lua"),
                ("linux", "aarch64", "", root / "lua5.1"),
                ("darwin", "arm64", "", root / "lua5.1"),
                ("win32", "AMD64", "custom", root / "custom"),
                ("linux", "x86_64", "custom", root / "custom"),
            ]
            # Keep one mock per line; Python 3.8 requires continuations for this layout.
            # fmt: off
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
            # fmt: on


class CreditNameTest(unittest.TestCase):
    def test_corrupt_git_output_fails_without_echoing_private_data(self):
        sha = "a" * 40
        outputs = [
            f"Signature for private@example.invalid\n{sha}\0Alice\0[fix] Test\0\0",
            f"{sha}\0private@example.invalid\0[fix] Missing field\0",
            f"{sha}\0Alice\0[fix] Missing terminator\0private@example.invalid",
            f"{sha}\0Alice\0[fix] Extra field\0\0private@example.invalid\0",
        ]
        for output in outputs:
            with self.subTest(output=output), patch.object(
                packager.release_notes.subprocess,
                "run",
                side_effect=[
                    subprocess.CompletedProcess([], 0, stdout=b"false\n"),
                    subprocess.CompletedProcess([], 0, stdout=b""),
                    subprocess.CompletedProcess([], 0, stdout=output.encode("utf-8")),
                ],
            ):
                with self.assertRaisesRegex(ValueError, "Git changelog") as error:
                    packager.release_notes.changelog(
                        ROOT, "1.2.3", sha, "https://github.com/Questie/QuestieDB"
                    )
                self.assertNotIn("private@example.invalid", str(error.exception))

    def test_display_name_privacy_fixtures(self):
        for case in CREDIT_FIXTURES["names"]:
            with self.subTest(case=case["case"]):
                self.assertEqual(
                    case["public"], packager.release_notes.public_credit_name(case["name"])
                )

    def test_controls_are_rejected_at_every_position_not_trimmed(self):
        for code in [*range(32), *range(127, 160)]:
            for template in ("{}Alice", "Ali{}ce", "Alice{}"):
                with self.subTest(code=code, template=template):
                    self.assertIsNone(
                        packager.release_notes.public_credit_name(template.format(chr(code)))
                    )
        for name in ("", "   ", "[]", "---"):
            with self.subTest(name=name):
                self.assertIsNone(packager.release_notes.public_credit_name(name))


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

    def git(self, *args, env=None):
        return subprocess.run(
            ["git", "-C", str(self.root), *args],
            check=True,
            env=env,
            capture_output=True,
            text=True,
            encoding="utf-8",
        ).stdout.strip()

    def commit(self, subject, author=None):
        env = (
            None
            if author is None
            else dict(
                os.environ, GIT_AUTHOR_NAME=author, GIT_AUTHOR_EMAIL="private@example.invalid"
            )
        )
        self.git(
            "-c", "core.hooksPath=", "commit", "--quiet", "--allow-empty", "-m", subject, env=env
        )
        return self.git("rev-parse", "HEAD")

    def changes(self, version="1.2.3-dev.abcdef0"):
        return packager.release_notes.changelog(
            self.root, version, self.git("rev-parse", "HEAD"), self.url
        )

    def notes(self, version="1.2.3-dev.abcdef0"):
        return self.changes(version).markdown

    def test_questie_prefixes_group_sort_and_preserve_authored_text(self):
        for subject in (
            "[fix] Zed",
            "[FEATURE] Added a feature",
            "[Fix] Alpha [fix] stays",
            "[quest] Quest change",
            "[db] Database change",
            "[locale]Translation change",
            "[fix]   ",
            "[other] Not included",
            "fix: Not included",
            "Some [fix] Not included",
            "Internal change\n\n[fix] Body is not a subject",
        ):
            self.commit(subject)
        notes = self.notes()
        headings = [
            "New features",
            "General fixes",
            "Quest fixes",
            "Database fixes",
            "Localization fixes",
        ]
        self.assertEqual(
            sorted(notes.index("### " + heading) for heading in headings),
            [notes.index("### " + heading) for heading in headings],
        )
        self.assertLess(notes.index("- Alpha [fix] stays"), notes.index("- Zed"))
        self.assertIn("- Translation change", notes)
        self.assertIn("- Added a feature", notes)
        self.assertNotIn("Not included", notes)
        self.assertNotIn("Body is not", notes)
        self.assertEqual(6, notes.count("\n- "))
        self.assertEqual(
            [
                {"category": "feature", "text": "Added a feature"},
                {"category": "fix", "text": "Alpha [fix] stays"},
                {"category": "fix", "text": "Zed"},
                {"category": "quest", "text": "Quest change"},
                {"category": "db", "text": "Database change"},
                {"category": "locale", "text": "Translation change"},
            ],
            [
                {"category": entry["category"], "text": entry["text"]}
                for entry in self.changes().entries
            ],
        )

    def test_author_and_coauthor_credits_use_trailers_not_committer_or_body(self):
        self.git("config", "user.name", "Committer")
        self.git(
            "-c",
            "core.hooksPath=",
            "commit",
            "--quiet",
            "--allow-empty",
            "--author",
            "Álice [DB] <alice@example.invalid>",
            "-m",
            "[fix] Authored fix\n\n"
            "Co-authored-by: Body Mention <body@example.invalid>\n"
            "This paragraph is not a trailer block.\n\n"
            "Co-authored-by: Bob <bob@example.invalid>\n"
            "co-authored-by: Chloé <chloe@example.invalid>\n"
            "Co-authored-by: Bob <another@example.invalid>\n"
            "Co-authored-by: Álice [DB] <alice@example.invalid>\n"
            "Co-authored-by: Broken <private@example.invalid> <other@example.invalid>\n"
            "Co-authored-by: Missing address",
        )
        authored = self.git("rev-parse", "HEAD")
        solo = self.commit("[fix] No trailers")
        changes = self.changes()
        self.assertEqual(
            [
                {
                    "category": "fix",
                    "text": "Authored fix",
                    "commit": authored,
                    "author": "Álice [DB]",
                    "coAuthors": ["Bob", "Chloé"],
                },
                {
                    "category": "fix",
                    "text": "No trailers",
                    "commit": solo,
                    "author": "Committer",
                    "coAuthors": [],
                },
            ],
            changes.entries,
        )
        url = f"{self.url}/commit/{authored}"
        self.assertIn(
            f"- Authored fix ([Álice \\[DB\\]]({url}), [Bob]({url}), [Chloé]({url}))",
            changes.markdown,
        )
        self.assertIn(f"- No trailers ([Committer]({self.url}/commit/{solo}))", changes.markdown)
        self.assertNotIn("@example.invalid", changes.markdown + json.dumps(changes.entries))
        self.assertNotIn("Body Mention", changes.markdown)
        self.assertNotIn("Missing address", changes.markdown)

    def test_display_names_survive_real_git_without_publishing_private_metadata(self):
        for index, case in enumerate(CREDIT_FIXTURES["names"]):
            self.commit(f"[fix] Primary {index}", author=case["name"])
            self.commit(
                f"[fix] Coauthor {index}\n\nCo-authored-by: {case['name']} <hidden@example.invalid>"
            )
        changes = self.changes()
        entries = {entry["text"]: entry for entry in changes.entries}
        self.assertEqual(2 * len(CREDIT_FIXTURES["names"]), len(entries))
        for index, case in enumerate(CREDIT_FIXTURES["names"]):
            with self.subTest(case=case["case"]):
                self.assertEqual(
                    case["public"] or "Contributor", entries[f"Primary {index}"]["author"]
                )
                self.assertEqual([], entries[f"Primary {index}"]["coAuthors"])
                self.assertEqual("Release test", entries[f"Coauthor {index}"]["author"])
                self.assertEqual(
                    [case["public"]] if case["public"] else [],
                    entries[f"Coauthor {index}"]["coAuthors"],
                )
        self.assertNotIn("example.invalid", changes.markdown + json.dumps(changes.entries))

    def test_malformed_folded_and_duplicate_trailers_use_real_git_parsing(self):
        for index, case in enumerate(CREDIT_FIXTURES["trailers"]):
            self.commit(f"[fix] Trailer {index}\n\n{case['text']}")
        changes = self.changes()
        entries = {entry["text"]: entry for entry in changes.entries}
        self.assertEqual(len(CREDIT_FIXTURES["trailers"]), len(entries))
        for index, case in enumerate(CREDIT_FIXTURES["trailers"]):
            with self.subTest(case=case["case"]):
                self.assertEqual(case["public"], entries[f"Trailer {index}"]["coAuthors"])
        self.assertNotIn("example.invalid", changes.markdown + json.dumps(changes.entries))

    def test_privacy_filters_credits_not_explicitly_authored_changelog_text(self):
        self.commit(
            "[fix] Document contact@example.invalid\n\n"
            "Private body: private@example.invalid\n\n"
            "Co-authored-by: private@example.invalid <hidden@example.invalid>",
            author="private@example.invalid",
        )
        changes = self.changes()
        self.assertEqual("Document contact@example.invalid", changes.entries[0]["text"])
        self.assertEqual("Contributor", changes.entries[0]["author"])
        self.assertEqual([], changes.entries[0]["coAuthors"])
        self.assertIn("contact@example.invalid", changes.markdown)
        for address in ("private@example.invalid", "hidden@example.invalid"):
            self.assertNotIn(address, changes.markdown + json.dumps(changes.entries))

    @unittest.skipUnless(
        shutil.which("ssh-keygen"), "ssh-keygen is required for the signed-commit fixture"
    )
    def test_signature_diagnostics_cannot_enter_commit_links_or_manifest(self):
        key = self.root / "signing-key"
        subprocess.run(
            ["ssh-keygen", "-q", "-t", "ed25519", "-N", "", "-C", "fixture", "-f", str(key)],
            check=True,
            capture_output=True,
        )
        signers = self.root / "allowed-signers"
        address = "signature-private@example.invalid"
        signers.write_text(address + " " + key.with_suffix(".pub").read_text(), encoding="utf-8")
        self.git("config", "gpg.format", "ssh")
        self.git("config", "user.signingkey", str(key))
        self.git("config", "gpg.ssh.allowedSignersFile", str(signers))
        self.git("config", "log.showSignature", "true")
        self.git(
            "-c",
            "core.hooksPath=",
            "commit",
            "--quiet",
            "--allow-empty",
            "-S",
            "-m",
            "[fix] Signed fix",
        )
        sha = self.git("rev-parse", "HEAD")
        self.assertIn(address, self.git("log", "-1", "--format=%H"))
        changes = self.changes()
        self.assertEqual(
            [
                {
                    "category": "fix",
                    "text": "Signed fix",
                    "commit": sha,
                    "author": "Release test",
                    "coAuthors": [],
                }
            ],
            changes.entries,
        )
        self.assertIn(f"[Release test]({self.url}/commit/{sha})", changes.markdown)
        self.assertNotIn(address, changes.markdown + json.dumps(changes.entries))

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
        self.assertEqual([], self.changes().entries)

    def test_shallow_checkout_does_not_present_partial_history_as_complete(self):
        self.commit("[fix] Older change")
        self.git("tag", "v1.0.0")
        head = self.commit("[fix] New change")
        with tempfile.TemporaryDirectory(prefix="questiedb shallow ") as directory:
            clone = Path(directory) / "clone"
            subprocess.run(
                ["git", "clone", "--quiet", "--depth=1", self.root.as_uri(), str(clone)],
                check=True,
                capture_output=True,
            )
            changes = packager.release_notes.changelog(clone, "1.1.0", head, self.url)
        self.assertEqual([], changes.entries)
        notes = changes.markdown
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
            shutil.copy(
                ROOT / "tools/distribution" / filename, self.root / "tools/distribution" / filename
            )

        # Minimal runtime payload, plus files that must not leak into the archives.
        (self.root / "src").mkdir()
        shutil.copy(ROOT / "src/config.lua", self.root / "src" / "config.lua")
        self.write("src/types/Quest.t.lua", "---@meta _\n")
        self.write("src/types/General.t.lua", "---@meta _\n")
        self.write("src/types/consumer.test.lua", "-- not shipped\n")
        self.write("src/runtime.lua", "return 'shared runtime'\n")
        (self.root / "icons").mkdir()
        shutil.copyfile(
            ROOT / "icons/QuestieTDB_64x64.png", self.root / "icons/QuestieTDB_64x64.png"
        )
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
        shutil.copyfile(
            ROOT / "tools/distribution/fixtures/strip-static.lua",
            self.root / "tools/distribution/strip-static.lua",
        )

        for flavor in FLAVORS:
            self.write("support/%s.lua" % flavor, "return '%s'\n" % flavor)
            self.write(
                "QuestieDB_%s.toc" % flavor,
                "## X-QUESTIE-COMMIT: %s\n" % PIN
                + "## Version: 1.2.3-dev.abcdef0\n## X-Contract-Version: 2\n"
                + "## IconTexture: Interface\\AddOns\\QuestieDB\\icons\\QuestieTDB_64x64.png\n"
                + "src\\config.lua\nsrc\\runtime.lua\nsrc\\corrections\\Era\\fixes.lua\n"
                + "support\\%s.lua\n" % flavor
                + "## X-Quest-1-S: fixture\n",
            )

        self.env = dict(
            os.environ,
            PATH=str(self.bin),
            LUA=LUA,
            SOURCE_DATE_EPOCH="1700000000",
            QUESTIEDB_TEST_FAIL_STRIP="0",
        )
        self.env.pop("QUESTIE_COMMIT", None)

    def write(self, relative, content):
        path = self.root / relative
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(content.encode("utf-8"))

    def run_package(self, *flavors):
        command = [sys.executable, str(self.root / "tools/distribution/package.py"), *flavors]
        return subprocess.run(
            command, cwd=self.bin, env=self.env, capture_output=True, text=True, timeout=30
        )

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
        self.assertEqual([], manifest["changelog"])
        self.assertEqual("changelog", list(manifest)[-1])
        changelog = "# QuestieDB 1.2.3-dev.abcdef0\n\nChangelog unavailable: this package was built without Git history.\n"
        self.assertEqual([*FLAVORS, "All"], [entry["flavor"] for entry in manifest["artifacts"]])

        # Each flavor stands alone; the combined ZIP is exactly their union.
        union = set()
        for entry in manifest["artifacts"]:
            archive_path = dist / entry["file"]
            self.assertEqual(hashlib.sha256(archive_path.read_bytes()).hexdigest(), entry["sha256"])
            self.assertEqual(archive_path.stat().st_size, entry["bytes"])
            flavors = FLAVORS if entry["flavor"] == "All" else (entry["flavor"],)
            self.assertEqual(
                sum((self.root / ("QuestieDB_%s.toc" % f)).stat().st_size for f in flavors),
                entry["rawBytes"],
            )
            with zipfile.ZipFile(archive_path) as archive:
                self.assertIsNone(archive.testzip())
                names = {info.filename for info in archive.infolist() if not info.is_dir()}
                expected = {
                    "QuestieDB/src/config.lua",
                    "QuestieDB/src/runtime.lua",
                    "QuestieDB/src/corrections/Era/fixes.lua",
                    "QuestieDB/Types/Quest.t.lua",
                    "QuestieDB/Types/General.t.lua",
                    "QuestieDB/icons/QuestieTDB_64x64.png",
                    "QuestieDB/CHANGELOG.md",
                }
                expected.update("QuestieDB/QuestieDB_%s.toc" % f for f in flavors)
                expected.update("QuestieDB/support/%s.lua" % f for f in flavors)
                self.assertEqual(expected, names)
                self.assertEqual(
                    (self.root / "src/config.lua").read_bytes(),
                    archive.read("QuestieDB/src/config.lua"),
                )
                self.assertEqual(
                    (self.root / "icons/QuestieTDB_64x64.png").read_bytes(),
                    archive.read("QuestieDB/icons/QuestieTDB_64x64.png"),
                )
                self.assertEqual(
                    b"return 'dynamic only'\n",
                    archive.read("QuestieDB/src/corrections/Era/fixes.lua"),
                )
                self.assertEqual(changelog, archive.read("QuestieDB/CHANGELOG.md").decode("utf-8"))
                for name in names:
                    self.assertEqual(zipfile.ZIP_DEFLATED, archive.getinfo(name).compress_type)
                if entry["flavor"] == "All":
                    self.assertEqual(union, names)
                else:
                    union.update(names)

        self.assertEqual(
            "return 'unstripped'\n", (self.root / "src/corrections/Era/fixes.lua").read_text()
        )
        self.assertFalse((self.root / ".out/stage").exists())

        # Preview warnings and download links describe the artifacts actually built.
        notes = (dist / "RELEASE_NOTES.md").read_text()
        self.assertTrue(notes.startswith("# Unstable Pre-Release Build\n\n> [!WARNING]"))
        self.assertEqual(2, notes.count("> [!WARNING]"))
        self.assertIn(
            "**Looking for the Questie quest helper? "
            "[Download Questie here](https://github.com/Questie/Questie/releases/latest).**",
            notes,
        )
        self.assertIn(
            "QuestieDB is the standalone database used by Questie. "
            "It does not provide quest tracking or map markers on its own. "
            "Install it alongside Questie or another addon that uses its data.",
            notes,
        )
        self.assertLess(
            notes.index("Looking for the Questie quest helper?"), notes.index("## What's new")
        )
        self.assertIn("**Recommended: [QuestieDB-all.zip]", notes)
        self.assertIn(
            "Includes all game flavors. Your client automatically loads the matching database.",
            notes,
        )
        self.assertIn("/releases/download/preview/QuestieDB-all.zip", notes)
        self.assertIn("Interface/AddOns/QuestieDB/QuestieDB_<Flavor>.toc", notes)
        self.assertIn("GitHub's **Source code** archives are not the packaged addon", notes)
        self.assertIn("<summary>Build details and checksums</summary>", notes)
        self.assertIn("Supported API contracts: `1` to `2`", notes)
        self.assertIn("without Git history", notes)
        self.assertLess(notes.index("</details>"), notes.rindex("> [!WARNING]"))
        self.assertTrue(notes.rstrip().endswith("/releases/latest)."))

    @unittest.skipUnless(shutil.which("git"), "Git is required for changelog fixtures")
    def test_release_changelog_matches_manifest_notes_zips_and_bootstrap(self):
        def git(*args):
            return subprocess.run(
                ["git", "-C", str(self.root), *args],
                check=True,
                capture_output=True,
                text=True,
                encoding="utf-8",
            ).stdout.strip()

        # A prior release and hostile credits exercise selection and privacy end to end.
        git("init", "--quiet")
        git("config", "user.name", "Builder private@example.invalid")
        git("config", "user.email", "release@example.invalid")
        git("config", "commit.gpgsign", "false")
        git("config", "tag.gpgsign", "false")
        commits = []
        for subject in (
            "[fix] Previously released",
            "[db] Correct prerequisites",
            "[locale] Corrigé\n\nCo-authored-by: Translator <translator@example.invalid>\n"
            "Co-authored-by: private&#64;example.invalid <hidden@example.invalid>",
        ):
            git("-c", "core.hooksPath=", "commit", "--quiet", "--allow-empty", "-m", subject)
            commits.append(git("rev-parse", "HEAD"))
            if subject == "[fix] Previously released":
                git("tag", "v1.2.2")

        self.env["PATH"] = os.environ["PATH"]
        result = self.run_package("all")
        self.assertEqual(0, result.returncode, result.stdout + result.stderr)
        dist = self.root / ".out/dist"
        manifest = json.loads((dist / "release.json").read_text(encoding="utf-8"))
        verified = release_artifacts.verify(dist, git("rev-parse", "HEAD"))
        self.assertEqual(
            [dist / artifact["file"] for artifact in manifest["artifacts"]],
            [archive.path for archive in verified.archives],
        )
        self.assertEqual(
            [
                {
                    "category": "db",
                    "text": "Correct prerequisites",
                    "commit": commits[1],
                    "author": "Contributor",
                    "coAuthors": [],
                },
                {
                    "category": "locale",
                    "text": "Corrigé",
                    "commit": commits[2],
                    "author": "Contributor",
                    "coAuthors": ["Translator"],
                },
            ],
            manifest["changelog"],
        )
        self.assertEqual("changelog", list(manifest)[-1])
        notes = (dist / "RELEASE_NOTES.md").read_text(encoding="utf-8")

        # Every ZIP, the manifest, and the release page must carry the same changes.
        changelogs = []
        for artifact in manifest["artifacts"]:
            with zipfile.ZipFile(dist / artifact["file"]) as archive:
                changelogs.append(archive.read("QuestieDB/CHANGELOG.md").decode("utf-8"))
        self.assertEqual(6, len(changelogs))
        self.assertEqual([changelogs[0]] * 6, changelogs)
        changelog = changelogs[0]
        self.assertTrue(changelog.startswith("# QuestieDB 1.2.3-dev.abcdef0\n\n"))
        self.assertIn(changelog.split("\n\n", 1)[1].rstrip(), notes)
        for entry in manifest["changelog"]:
            self.assertIn("- " + entry["text"], changelog)
            for name in [entry["author"], *entry["coAuthors"]]:
                self.assertIn(
                    f"[{name}](https://github.com/Questie/QuestieDB/commit/{entry['commit']})",
                    changelog,
                )
        self.assertNotIn("example.invalid", changelog + notes + json.dumps(manifest))
        self.assertNotIn("Previously released", changelog)
        self.assertNotIn("Build details", changelog)

        # Consume the real packager output, not another independently authored ZIP fixture.
        addons = self.root / "AddOns"
        addons.mkdir()
        with patch.object(
            bootstrap,
            "download",
            side_effect=lambda url, destination: shutil.copyfile(
                dist / url.rsplit("/", 1)[-1], destination
            ),
        ), contextlib.redirect_stdout(io.StringIO()):
            installed = bootstrap.install(addons)
        self.assertEqual(changelog, (installed / "CHANGELOG.md").read_text(encoding="utf-8"))
        self.assertEqual(
            (self.root / "icons/QuestieTDB_64x64.png").read_bytes(),
            (installed / "icons/QuestieTDB_64x64.png").read_bytes(),
        )
        self.assertEqual(bootstrap.TOCS, {path.name for path in installed.glob("QuestieDB_*.toc")})

    def test_single_flavor_package(self):
        result = self.run_package("Vanilla")
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual(
            ["QuestieDB-Vanilla.zip"], [p.name for p in (self.root / ".out/dist").glob("*.zip")]
        )
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
        path.write_text(
            path.read_text().replace(
                "config.minSupportedContract = 1", "config.minSupportedContract = 2"
            )
        )
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
        for header in (
            "## Version: 01.2.3",
            "## Version:",
            "## Version: 1.2.3-dev.preview",
            "## Version: 1.2.3\n## version: 1.2.3",
            "## X-Contract-Version: 0",
            "## X-Contract-Version: 1.5",
            "## X-Contract-Version: 2\n## x-contract-version: 2",
        ):
            with self.subTest(header=header):
                self.preserve_previous_output()
                lines = original.splitlines()
                key = header.split(":", 1)[0]
                toc.write_text(
                    "\n".join(header if line.startswith(key + ":") else line for line in lines)
                    + "\n"
                )
                result = self.run_package("Vanilla")
                self.assertNotEqual(0, result.returncode, result.stdout)
                self.assert_previous_output()

    def test_invalid_runtime_config_preserves_previous_output(self):
        # test.lua's contract-config suite covers every rejected value; packaging only has to
        # prove that a configuration that fails to load aborts before output is cleared.
        self.preserve_previous_output()
        path = self.root / "src/config.lua"
        path.write_text(
            path.read_text().replace(
                "config.minSupportedContract = 1", "config.minSupportedContract = 3"
            )
        )
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
