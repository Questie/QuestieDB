"""Release policy tests use temporary Git/ZIP inputs and a fake GitHub CLI only.

Run: uv run tools/distribution/release.test.py
No real GitHub CLI command, network request, tag update, or publication is performed.
"""

import contextlib
import hashlib
import io
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
import zipfile

import release
from package import find_lua


ROOT = Path(__file__).resolve().parents[2]
try:
    LUA = find_lua()
except ValueError:
    LUA = None


class PrerequisiteTest(unittest.TestCase):
    def test_missing_github_cli_blocks_both_commands_before_work_starts(self):
        for command in ("preflight", "publish"):
            with self.subTest(command=command), contextlib.ExitStack() as stack:
                which = stack.enter_context(
                    patch.object(release.shutil, "which", return_value=None)
                )
                preflight = stack.enter_context(patch.object(release, "preflight"))
                publish = stack.enter_context(patch.object(release, "publish"))
                stderr = stack.enter_context(contextlib.redirect_stderr(io.StringIO()))

                self.assertEqual(1, release.main([command]))
                which.assert_called_once_with("gh")
                preflight.assert_not_called()
                publish.assert_not_called()
                self.assertIn("GitHub CLI (gh) is required", stderr.getvalue())
                self.assertIn("https://cli.github.com/", stderr.getvalue())
                self.assertIn("PATH", stderr.getvalue())

    def test_help_does_not_require_github_cli(self):
        with patch.object(release.shutil, "which") as which, contextlib.redirect_stdout(
            io.StringIO()
        ):
            with self.assertRaises(SystemExit) as result:
                release.main(["--help"])
            self.assertEqual(0, result.exception.code)
            which.assert_not_called()


@unittest.skipUnless(
    LUA and shutil.which("git"), "Lua 5.1 and Git are required for release fixtures"
)
class ReleaseTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb release policy ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        previous_cwd = Path.cwd()
        os.chdir(self.root)
        self.addCleanup(os.chdir, previous_cwd)

        subprocess.run(["git", "init", "--quiet"], check=True, capture_output=True)
        subprocess.run(
            [
                "git",
                "-c",
                "user.name=Release test",
                "-c",
                "user.email=test@example.invalid",
                "-c",
                "commit.gpgsign=false",
                "-c",
                "core.hooksPath=",
                "commit",
                "--quiet",
                "--allow-empty",
                "-m",
                "fixture",
            ],
            check=True,
            capture_output=True,
        )
        self.commit = subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip()
        Path("generator").mkdir()
        shutil.copyfile(ROOT / "generator/version.lua", "generator/version.lua")
        Path("QuestieDB.toc").write_text("## Version: 1.2.3\n", encoding="utf-8")

        self.dist = Path(".out/dist")
        self.dist.mkdir(parents=True)
        (self.dist / "RELEASE_NOTES.md").write_text("# Release notes\n", encoding="utf-8")
        self.archives = []
        artifacts = []
        for flavor in ("Vanilla", "TBC", "Wrath", "Cata", "Mists", "all"):
            path = self.dist / f"QuestieDB-{flavor}.zip"
            with zipfile.ZipFile(path, "w") as archive:
                archive.writestr("QuestieDB/CHANGELOG.md", "# Changes\n")
            self.archives.append(str(path))
            artifacts.append(
                {"file": path.name, "sha256": hashlib.sha256(path.read_bytes()).hexdigest()}
            )
        (self.dist / "release.json").write_text(
            json.dumps(
                {
                    "releases": [],
                    "questiedb": {
                        "version": "1.2.3",
                        "producerCommit": self.commit,
                        "artifacts": artifacts,
                    },
                }
            ),
            encoding="utf-8",
        )

        self.env = {
            "GITHUB_REPOSITORY": "Owner/Database",
            "GH_REPO": "Owner/Database",
            "GITHUB_REF": "refs/heads/master",
            "DEFAULT_BRANCH": "master",
            "GITHUB_SHA": self.commit,
            "GITHUB_OUTPUT": str(self.root / "outputs"),
            "QUESTIEDB_RELEASE": "true",
            "RELEASE_OVERRIDE": "false",
            "DRY_RUN": "false",
            "TAG": "v1.2.3",
        }
        self.state = {"release": None, "ref": None}
        self.immutable = "false"
        self.current = "b" * 40
        self.comparison = "ahead"
        self.read_failure = None
        self.fail_write = None
        self.reads = []
        self.writes = []

    def github_read(self, *args):
        self.reads.append(args)
        if self.read_failure is not None:
            if isinstance(self.read_failure, Exception):
                raise self.read_failure
            return self.read_failure
        if args[:2] == ("api", "graphql"):
            return json.dumps(self.state)
        endpoint = args[1]
        if endpoint == "repos/Owner/Database/releases/42":
            return self.immutable
        if endpoint == "repos/Owner/Database/commits/refs%2Ftags%2Fpreview":
            return self.current
        if endpoint == f"repos/Owner/Database/compare/{self.current}...{self.commit}":
            return self.comparison
        self.fail(f"Unexpected GitHub read: {args}")

    def github_write(self, *args):
        self.writes.append(args)
        if len(self.writes) == self.fail_write:
            raise subprocess.CalledProcessError(1, ["gh", *args])

    def run_action(self, action):
        check_output = subprocess.check_output
        run = subprocess.run

        def local_run(args, **kwargs):
            # Intercept the process boundary so the real CLI can never reach GitHub.
            if args[0] == "gh":
                if kwargs.get("stdout") == subprocess.PIPE:
                    output = self.github_read(*args[1:])
                else:
                    self.github_write(*args[1:])
                    output = None
                return subprocess.CompletedProcess(args, 0, stdout=output)
            return run(args, **kwargs)

        def local_output(args, **kwargs):
            # Actions installs lua5.1; local tests can use the bundled interpreter instead.
            if args[0] == "lua5.1":
                args = [LUA, *args[1:]]
                kwargs["stderr"] = subprocess.PIPE
            return check_output(args, **kwargs)

        stdout, stderr = io.StringIO(), io.StringIO()
        with contextlib.ExitStack() as stack:
            stack.enter_context(patch.dict(os.environ, self.env))
            stack.enter_context(patch.object(release.shutil, "which", return_value="fake-gh"))
            stack.enter_context(
                patch.object(release.subprocess, "check_output", side_effect=local_output)
            )
            stack.enter_context(patch.object(release.subprocess, "run", side_effect=local_run))
            stack.enter_context(contextlib.redirect_stdout(stdout))
            stack.enter_context(contextlib.redirect_stderr(stderr))
            result = release.main([action])
        self.stdout, self.stderr = stdout.getvalue(), stderr.getvalue()
        return result

    def test_dry_run_selects_stable_or_preview_without_github_calls(self):
        self.env["DRY_RUN"] = "true"
        self.state = {"release": {"databaseId": 42}, "ref": {"name": "v1.2.3"}}
        for full, tag in (("true", "v1.2.3"), ("false", "preview")):
            with self.subTest(full_release=full):
                self.env["QUESTIEDB_RELEASE"] = full
                self.assertEqual(0, self.run_action("preflight"), self.stderr)
                self.assertTrue(Path("outputs").read_text().endswith(f"tag={tag}\n"))
                self.assertIn("Dry run:", self.stdout)
                self.assertEqual([], self.reads)
                self.assertEqual([], self.writes)

    def test_preflight_rejects_wrong_branch_and_invalid_override_before_github(self):
        self.env["GITHUB_REF"] = "refs/heads/topic"
        self.assertEqual(1, self.run_action("preflight"))
        self.env.update(
            GITHUB_REF="refs/heads/master", QUESTIEDB_RELEASE="false", RELEASE_OVERRIDE="true"
        )
        self.assertEqual(1, self.run_action("preflight"))
        self.assertIn("override applies only", self.stderr)
        self.assertEqual([], self.reads)
        self.assertFalse(Path("outputs").exists())

    def test_preflight_uses_the_existing_lua_version_validation(self):
        for headers in ("## Version: 01.2.3\n", "## Version: 1.2.3\n## Version: 1.2.4\n"):
            with self.subTest(headers=headers):
                Path("QuestieDB.toc").write_text(headers, encoding="utf-8")
                self.assertEqual(1, self.run_action("preflight"))
                self.assertFalse(Path("outputs").exists())
                self.assertEqual([], self.reads)

    def test_preflight_collision_check_includes_drafts_and_bare_tags(self):
        for state in (
            {"release": {"databaseId": 42}, "ref": None},
            {"release": None, "ref": {"name": "v1.2.3"}},
        ):
            with self.subTest(state=state):
                self.state = state
                self.assertEqual(1, self.run_action("preflight"))
                self.assertIn("already exists", self.stderr)
        self.assertIn("owner=Owner", self.reads[0])
        self.assertIn("repo=Database", self.reads[0])
        self.assertIn("ref=refs/tags/v1.2.3", self.reads[0])
        self.env["RELEASE_OVERRIDE"] = "true"
        self.assertEqual(0, self.run_action("preflight"), self.stderr)
        self.env.update(QUESTIEDB_RELEASE="false", RELEASE_OVERRIDE="false")
        self.assertEqual(0, self.run_action("preflight"), self.stderr)
        self.assertEqual([], self.writes)

    def test_new_stable_release_uploads_all_verified_assets_before_publication(self):
        self.assertEqual(0, self.run_action("publish"), self.stderr)
        self.assertEqual(
            [
                (
                    "release",
                    "create",
                    "v1.2.3",
                    "--target",
                    self.commit,
                    "--draft",
                    "--title",
                    "QuestieDB 1.2.3",
                    "--notes-file",
                    ".out/dist/RELEASE_NOTES.md",
                ),
                (
                    "release",
                    "upload",
                    "v1.2.3",
                    *self.archives,
                    ".out/dist/RELEASE_NOTES.md",
                    "--clobber",
                ),
                ("release", "upload", "v1.2.3", ".out/dist/release.json", "--clobber"),
                (
                    "release",
                    "edit",
                    "v1.2.3",
                    "--draft=false",
                    "--target",
                    self.commit,
                    "--title",
                    "QuestieDB 1.2.3",
                    "--notes-file",
                    ".out/dist/RELEASE_NOTES.md",
                    "--prerelease=false",
                    "--latest=true",
                ),
            ],
            self.writes,
        )

    def test_new_preview_never_becomes_latest_stable(self):
        self.env.update(QUESTIEDB_RELEASE="false", TAG="preview")
        self.assertEqual(0, self.run_action("publish"), self.stderr)
        self.assertEqual(("release", "create", "preview"), self.writes[0][:3])
        self.assertIn("Unstable Pre-Release Development Build (master-branch)", self.writes[-1])
        self.assertEqual(("--prerelease=true", "--latest=false"), self.writes[-1][-2:])

    def test_override_moves_tag_after_zips_and_before_manifest(self):
        self.env["RELEASE_OVERRIDE"] = "true"
        self.state = {"release": {"databaseId": 42}, "ref": {"name": "v1.2.3"}}
        self.assertEqual(0, self.run_action("publish"), self.stderr)
        self.assertEqual(
            (
                "release",
                "upload",
                "v1.2.3",
                *self.archives,
                ".out/dist/RELEASE_NOTES.md",
                "--clobber",
            ),
            self.writes[0],
        )
        self.assertEqual(
            (
                "api",
                "repos/Owner/Database/git/refs/tags/v1.2.3",
                "--method",
                "PATCH",
                "-f",
                f"sha={self.commit}",
                "-F",
                "force=true",
            ),
            self.writes[1],
        )
        self.assertEqual(
            ("release", "upload", "v1.2.3", ".out/dist/release.json", "--clobber"), self.writes[2]
        )
        self.assertEqual(("release", "edit", "v1.2.3"), self.writes[3][:3])
        self.assertEqual(4, len(self.writes))

    def test_publication_rechecks_collision_after_successful_preflight(self):
        self.assertEqual(0, self.run_action("preflight"), self.stderr)
        self.state["ref"] = {"name": "v1.2.3"}
        self.assertEqual(1, self.run_action("publish"))
        self.assertIn("already exists", self.stderr)
        self.assertEqual(2, len(self.reads))
        self.assertEqual([], self.writes)

    def test_immutable_release_cannot_be_overridden(self):
        self.env["RELEASE_OVERRIDE"] = "true"
        self.state["release"] = {"databaseId": 42}
        self.immutable = "true"
        self.assertEqual(1, self.run_action("publish"))
        self.assertIn("immutable", self.stderr)
        self.assertEqual([], self.writes)

    def test_preview_ancestry_controls_replacement(self):
        self.env.update(QUESTIEDB_RELEASE="false", TAG="preview")
        self.state = {"release": {"databaseId": 42}, "ref": {"name": "preview"}}
        for comparison, status, publishes in (
            ("behind", 0, False),
            ("diverged", 1, False),
            ("ahead", 0, True),
            ("identical", 0, True),
        ):
            with self.subTest(comparison=comparison):
                self.reads.clear()
                self.writes.clear()
                self.comparison = comparison
                self.assertEqual(status, self.run_action("publish"), self.stderr)
                self.assertEqual(publishes, bool(self.writes))
                if publishes:
                    self.assertEqual(("release", "upload", "preview"), self.writes[0][:3])
                    self.assertEqual(("--prerelease=true", "--latest=false"), self.writes[-1][-2:])

    def test_dry_run_wrong_checkout_and_wrong_branch_never_contact_github(self):
        for changed in (
            {"DRY_RUN": "true"},
            {"GITHUB_SHA": "c" * 40},
            {"GITHUB_REF": "refs/heads/topic"},
        ):
            with self.subTest(changed=changed), patch.dict(self.env, changed):
                self.assertEqual(1, self.run_action("publish"))
                self.assertEqual([], self.reads)
                self.assertEqual([], self.writes)

    def test_bad_handoff_aborts_before_any_github_call(self):
        with Path(self.archives[-1]).open("ab") as archive:
            archive.write(b"corruption")
        self.assertEqual(1, self.run_action("publish"))
        self.assertIn("checksum mismatch", self.stderr)
        self.assertEqual([], self.reads)
        self.assertEqual([], self.writes)

    def test_api_failures_and_unavailable_state_never_become_absence(self):
        for failure in (
            "null",
            "[]",
            "invalid JSON",
            subprocess.CalledProcessError(1, ["gh", "api"]),
        ):
            with self.subTest(failure=failure):
                self.read_failure = failure
                self.assertEqual(1, self.run_action("preflight"))
                self.assertEqual(1, self.run_action("publish"))
                self.assertEqual([], self.writes)

    def test_failed_publication_stops_before_later_mutations(self):
        self.env["RELEASE_OVERRIDE"] = "true"
        self.state = {"release": {"databaseId": 42}, "ref": {"name": "v1.2.3"}}
        for failure in (1, 2, 3, 4):
            with self.subTest(failed_write=failure):
                self.writes.clear()
                self.fail_write = failure
                self.assertEqual(1, self.run_action("publish"))
                self.assertEqual(failure, len(self.writes))


if __name__ == "__main__":
    unittest.main()
