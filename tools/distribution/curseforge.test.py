"""CurseForge upload tests use temporary Git remotes and a fake curl; nothing reaches CurseForge.

Run: uv run tools/distribution/curseforge.test.py
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

import curseforge
from package import FLAVORS

GIT = shutil.which("git")


@unittest.skipUnless(GIT, "git is required")
class UploadTest(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix="questiedb curseforge ")
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        remote = self.root / "origin.git"
        self.work = self.root / "work"
        subprocess.run([GIT, "init", "--bare", "-q", str(remote)], check=True)
        subprocess.run([GIT, "clone", "-q", str(remote), str(self.work)], check=True, capture_output=True)
        self.git("-c", "user.name=T", "-c", "user.email=t@example.org", "commit", "--allow-empty", "-qm", "x")
        self.commit = self.git("rev-parse", "HEAD")
        self.git("push", "-q", "origin", f"{self.commit}:refs/tags/v1.0.9")

        self.dist = self.root / "dist"
        self.dist.mkdir()
        artifacts = []
        for flavor in (*FLAVORS, "all"):
            path = self.dist / f"QuestieDB-{flavor}.zip"
            with zipfile.ZipFile(path, "w") as archive:
                archive.writestr("QuestieDB/x.lua", flavor)
            digest = hashlib.sha256(path.read_bytes()).hexdigest()
            artifacts.append({"file": path.name, "sha256": digest})
        manifest = {"questiedb": {"version": "1.0.9", "producerCommit": self.commit, "artifacts": artifacts}}
        (self.dist / "release.json").write_text(json.dumps(manifest))
        (self.dist / "RELEASE_NOTES.md").write_text("# QuestieDB 1.0.9\n\n- Fix.\n\n## Download\n\nzip\n\n## Installation\n\nSteps.\n")

        self.uploads = []
        cwd = os.getcwd()
        os.chdir(self.work)
        self.addCleanup(os.chdir, cwd)
        patcher = patch.object(curseforge, "upload_file", side_effect=self.record)
        patcher.start()
        self.addCleanup(patcher.stop)
        env = patch.dict(os.environ, {"CF_API_TOKEN": "token"})
        env.start()
        self.addCleanup(env.stop)

    def git(self, *args):
        return subprocess.check_output([GIT, "-C", str(self.work), *args], text=True).strip()

    def record(self, project, path, metadata):
        self.uploads.append((project, path.name, metadata))

    def run_upload(self, *args):
        stderr = io.StringIO()
        with contextlib.redirect_stdout(io.StringIO()), contextlib.redirect_stderr(stderr):
            code = curseforge.main(["v1.0.9", str(self.dist), *args])
        return code, stderr.getvalue()

    def remote_markers(self):
        output = self.git("ls-remote", "--tags", "origin", "refs/tags/curse/*")
        return sorted(line.split("refs/tags/")[1] for line in output.splitlines())

    def test_should_upload_each_flavor_with_questies_game_version_after_reserving_it(self):
        self.assertEqual(self.run_upload(), (0, ""))
        self.assertEqual(
            [(name, meta["gameVersions"]) for _, name, meta in self.uploads],
            [
                ("QuestieDB-Vanilla.zip", [16630]),
                ("QuestieDB-Forever.zip", [17053]),
                ("QuestieDB-TBC.zip", [16533]),
                ("QuestieDB-Wrath.zip", [16785]),
                ("QuestieDB-Mists.zip", [16168]),
            ],
        )
        project, _, metadata = self.uploads[0]
        self.assertEqual(project, "1696795")
        self.assertEqual(metadata["releaseType"], "release")
        self.assertEqual(metadata["displayName"], "v1.0.9 (Vanilla)")
        self.assertEqual(metadata["changelog"], "# QuestieDB 1.0.9\n\n- Fix.\n")
        self.assertEqual(
            self.remote_markers(), sorted(f"curse/v1.0.9/{f}" for f in curseforge.GAME_VERSIONS)
        )

    def test_should_skip_flavors_that_are_already_reserved(self):
        self.git("push", "-q", "origin", f"{self.commit}:refs/tags/curse/v1.0.9/TBC")
        self.assertEqual(self.run_upload()[0], 0)
        self.assertNotIn("QuestieDB-TBC.zip", [name for _, name, _ in self.uploads])
        self.assertEqual(len(self.uploads), 4)

    def test_should_refuse_before_any_upload_when_a_later_flavor_belongs_to_another_commit(self):
        self.git("-c", "user.name=T", "-c", "user.email=t@example.org", "commit", "--allow-empty", "-qm", "old")
        self.git("push", "-q", "origin", "HEAD:refs/tags/curse/v1.0.9/Mists")
        code, stderr = self.run_upload()
        self.assertEqual(code, 1)
        self.assertIn("curse/v1.0.9/Mists was reserved for another commit", stderr)
        self.assertEqual(self.uploads, [])
        self.assertEqual(self.remote_markers(), ["curse/v1.0.9/Mists"])

    def test_should_keep_the_reservation_and_stop_when_an_upload_fails(self):
        error = subprocess.CalledProcessError(22, ["curl"], output='{"error":"bad"}')
        with patch.object(curseforge, "upload_file", side_effect=error):
            code, stderr = self.run_upload()
        self.assertEqual(code, 1)
        self.assertIn("git push origin --delete curse/v1.0.9/Vanilla", stderr)
        self.assertEqual(self.remote_markers(), ["curse/v1.0.9/Vanilla"])

    def test_should_neither_reserve_nor_upload_in_a_dry_run(self):
        self.assertEqual(self.run_upload("--dry-run")[0], 0)
        self.assertEqual((self.uploads, self.remote_markers()), ([], []))

    def test_should_reject_preview_and_missing_tags(self):
        for tag, message in (("preview", "Only stable"), ("v9.9.9", "does not exist")):
            with self.subTest(tag=tag), contextlib.redirect_stderr(io.StringIO()) as stderr:
                self.assertEqual(curseforge.main([tag, str(self.dist)]), 1)
                self.assertIn(message, stderr.getvalue())
        self.assertEqual((self.uploads, self.remote_markers()), ([], []))

    def test_should_reject_assets_from_another_commit(self):
        self.git("-c", "user.name=T", "-c", "user.email=t@example.org", "commit", "--allow-empty", "-qm", "y")
        self.git("push", "-q", "-f", "origin", "HEAD:refs/tags/v1.0.9")
        code, stderr = self.run_upload()
        self.assertEqual(code, 1)
        self.assertIn("producing commit", stderr)
        self.assertEqual(self.uploads, [])


if __name__ == "__main__":
    unittest.main()
