"""Shared verification and previews use disposable ZIPs, never GitHub or installed addons.

Run: uv run tools/distribution/release_artifacts.test.py
"""

import contextlib
import hashlib
import io
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
import zipfile

import preview
import release_artifacts


class ReleaseFixture(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="questiedb release handoff ")
        self.addCleanup(self.temp.cleanup)
        self.dist = Path(self.temp.name) / "dist"
        self.dist.mkdir()
        self.summary = Path(self.temp.name) / "summary.md"
        self.commit = "a" * 40
        self.notes = "# QuestieDB 1.0.1\n\n## What's new\n\n- Corrigé.\n"
        (self.dist / "RELEASE_NOTES.md").write_text(self.notes, encoding="utf-8")

        artifacts = []
        for flavor in ("Vanilla", "TBC", "Wrath", "Cata", "Mists", "Forever", "all"):
            filename = f"QuestieDB-{flavor}.zip"
            path = self.dist / filename
            with zipfile.ZipFile(path, "w") as archive:
                archive.writestr("QuestieDB/", "")
                archive.writestr("QuestieDB/CHANGELOG.md", "# Changes\n")
                archive.writestr("QuestieDB/src/config.lua", "return {}\n")
                archive.writestr("QuestieDB/icons/<sample>&.png", b"image fixture")
            artifacts.append(
                {"file": filename, "sha256": hashlib.sha256(path.read_bytes()).hexdigest()}
            )
        self.manifest = {"version": "1.0.1", "producerCommit": self.commit, "artifacts": artifacts}
        self.write_manifest()

    def write_manifest(self):
        (self.dist / "release.json").write_text(
            json.dumps({"releases": [], "questiedb": self.manifest}), encoding="utf-8"
        )

    def run_verifier(self, commit=None):
        return subprocess.run(
            [
                sys.executable,
                str(Path(release_artifacts.__file__)),
                str(self.dist),
                "--commit",
                commit or self.commit,
            ],
            capture_output=True,
            text=True,
            timeout=10,
        )

    def run_preview(self, commit=None):
        with contextlib.redirect_stdout(io.StringIO()), contextlib.redirect_stderr(io.StringIO()):
            return preview.main(
                [str(self.dist), "--commit", commit or self.commit, "--summary", str(self.summary)]
            )


class VerificationTest(ReleaseFixture):
    def assert_rejected_by_both(self, commit=None):
        result = self.run_verifier(commit)
        self.assertEqual(1, result.returncode, result.stderr)
        self.assertEqual("", result.stdout, "a failed handoff must not yield a partial upload list")
        self.assertIn("release-artifacts:", result.stderr)
        self.assertEqual(1, self.run_preview(commit))

    def test_cli_upload_paths_match_shared_verified_release(self):
        release = release_artifacts.verify(self.dist, self.commit)
        self.assertEqual("1.0.1", release.version)
        self.assertEqual(self.commit, release.producer_commit)
        self.assertEqual(self.notes, release.notes)
        expected_paths = [str(self.dist / entry["file"]) for entry in self.manifest["artifacts"]]
        self.assertEqual(expected_paths, [str(archive.path) for archive in release.archives])
        self.assertEqual(4, len(release.archives[0].files))

        result = self.run_verifier()
        self.assertEqual(0, result.returncode, result.stderr)
        self.assertEqual(expected_paths, result.stdout.splitlines())
        self.assertEqual("", result.stderr)
        self.assertFalse((self.dist / "DRY_RUN.md").exists())

    def test_wrong_commit_or_checksum_preserves_previous_report(self):
        output = self.dist / "DRY_RUN.md"
        output.write_text("previous report", encoding="utf-8")
        self.summary.write_text("previous summary", encoding="utf-8")
        self.assert_rejected_by_both(commit="b" * 40)

        # Damage the final archive so an incremental CLI would already have emitted paths.
        with (self.dist / "QuestieDB-all.zip").open("ab") as archive:
            archive.write(b"corruption")
        self.assert_rejected_by_both()
        self.assertEqual("previous report", output.read_text(encoding="utf-8"))
        self.assertEqual("previous summary", self.summary.read_text(encoding="utf-8"))

    def test_incomplete_duplicate_or_unsafe_archive_set_is_rejected(self):
        original = self.manifest["artifacts"]
        for artifacts in (
            original[:-1],
            original + original[:1],
            original[:-1] + [{"file": "../outside.zip", "sha256": "a" * 64}],
        ):
            with self.subTest(artifacts=artifacts):
                self.manifest["artifacts"] = artifacts
                self.write_manifest()
                self.assert_rejected_by_both()
                self.assertFalse((self.dist / "DRY_RUN.md").exists())
                self.assertFalse(self.summary.exists())

    def test_malformed_manifest_fields_are_rejected(self):
        valid = self.manifest
        for document in ([], {}, {"questiedb": None}, valid):
            with self.subTest(document=document):
                (self.dist / "release.json").write_text(json.dumps(document), encoding="utf-8")
                self.assert_rejected_by_both()

        for manifest in (
            [],
            {},
            dict(valid, version=None),
            dict(valid, producerCommit="bad"),
            dict(valid, artifacts=None),
            dict(valid, artifacts=[None]),
            dict(valid, artifacts=[{"file": []}]),
        ):
            with self.subTest(manifest=manifest):
                self.manifest = manifest
                self.write_manifest()
                self.assert_rejected_by_both()

        self.manifest = valid
        for digest in (None, "a" * 63, "A" * 64):
            with self.subTest(digest=digest):
                self.manifest["artifacts"][-1]["sha256"] = digest
                self.write_manifest()
                self.assert_rejected_by_both()

    def test_missing_release_notes_are_rejected(self):
        (self.dist / "RELEASE_NOTES.md").unlink()
        self.assert_rejected_by_both()

    def test_invalid_zip_is_rejected_even_when_its_checksum_matches(self):
        path = self.dist / "QuestieDB-all.zip"
        path.write_bytes(b"not a ZIP")
        self.manifest["artifacts"][-1]["sha256"] = hashlib.sha256(path.read_bytes()).hexdigest()
        self.write_manifest()
        self.assert_rejected_by_both()
        self.assertFalse((self.dist / "DRY_RUN.md").exists())


class PreviewTest(ReleaseFixture):
    def test_report_inspects_verified_zips_and_reuses_notes_without_changing_release_assets(self):
        originals = {path: path.read_bytes() for path in self.dist.iterdir()}
        self.assertEqual(0, self.run_preview())
        report = (self.dist / "DRY_RUN.md").read_text(encoding="utf-8")
        self.assertEqual(report, self.summary.read_text(encoding="utf-8"))
        self.assertTrue(report.startswith("# Release dry run\n"))
        self.assertIn("No tags or GitHub releases were created or changed.", report)
        self.assertIn("may point to an older published release", report)
        self.assertEqual(self.notes, report.split("## GitHub release description\n\n---\n\n", 1)[1])
        self.assertEqual(7, report.count("<details>"))
        for artifact in self.manifest["artifacts"]:
            self.assertIn(f"<summary>{artifact['file']}</summary>", report)
            self.assertIn(artifact["sha256"], report)
        self.assertIn("QuestieDB/CHANGELOG.md  (10 bytes)", report)
        self.assertIn("QuestieDB/icons/&lt;sample&gt;&amp;.png", report)
        for path, content in originals.items():
            self.assertEqual(content, path.read_bytes())
        self.assertEqual({*originals, self.dist / "DRY_RUN.md"}, set(self.dist.iterdir()))

    def test_large_preview_keeps_full_report_and_uses_short_actions_summary(self):
        self.notes += "é" * 800_000
        (self.dist / "RELEASE_NOTES.md").write_text(self.notes, encoding="utf-8")
        self.assertEqual(0, self.run_preview())
        report = (self.dist / "DRY_RUN.md").read_text(encoding="utf-8")
        summary = self.summary.read_text(encoding="utf-8")
        self.assertLess(len(report), preview.SUMMARY_LIMIT)
        self.assertGreater(len(report.encode("utf-8")), preview.SUMMARY_LIMIT)
        self.assertTrue(report.endswith(self.notes))
        self.assertLess(len(summary.encode("utf-8")), preview.SUMMARY_LIMIT)
        self.assertIn("Download `DRY_RUN.md`", summary)


if __name__ == "__main__":
    unittest.main()
