#!/usr/bin/env python3
"""Verify a complete release handoff and print its approved ZIP paths for publication.

Usage: python3 tools/distribution/release_artifacts.py .out/dist --commit SHA
No paths are printed unless the entire handoff passes. Never modifies files or GitHub state.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
import json
from pathlib import Path
import re
import sys
import zipfile

from package import FLAVORS, sha256


@dataclass(frozen=True)
class ReleaseArchive:
    """An approved archive and its directory entries, without extracting its contents."""

    path: Path
    sha256: str
    files: tuple[zipfile.ZipInfo, ...]


@dataclass(frozen=True)
class VerifiedRelease:
    """The shared handoff consumed by reporting and publication."""

    version: str
    producer_commit: str
    notes: str
    archives: tuple[ReleaseArchive, ...]


def verify(dist: Path, expected_commit: str | None = None) -> VerifiedRelease:
    """Validate release identity, the complete ZIP inventory, checksums, and readable payloads.

    Publication requires an expected commit. Local reports may omit it, but still validate
    the producing SHA and all other handoff requirements.
    """
    manifest = json.loads((dist / "release.json").read_text(encoding="utf-8"))
    notes = (dist / "RELEASE_NOTES.md").read_text(encoding="utf-8")

    if not isinstance(manifest, dict):
        raise ValueError("release manifest must be an object")

    version = manifest.get("version")
    commit = manifest.get("producerCommit")
    if not isinstance(version, str) or not version:
        raise ValueError("release manifest must contain an addon version")
    if not isinstance(commit, str) or not re.fullmatch(r"[0-9a-f]{40}", commit):
        raise ValueError("release manifest must contain a valid producing commit")
    if expected_commit is not None and commit != expected_commit:
        raise ValueError("release manifest does not match the requested producing commit")

    # The packager owns supported flavors. Only its complete, unique ZIP set can be published.
    artifacts = manifest.get("artifacts")
    if not isinstance(artifacts, list) or any(
        not isinstance(artifact, dict) for artifact in artifacts
    ):
        raise ValueError("release manifest must contain an artifact list")

    filenames = [artifact.get("file") for artifact in artifacts]
    expected_files = {f"QuestieDB-{flavor}.zip" for flavor in (*FLAVORS, "all")}
    if (
        any(not isinstance(filename, str) for filename in filenames)
        or len(filenames) != len(expected_files)
        or set(filenames) != expected_files
    ):
        raise ValueError(
            "release manifest must contain every flavor ZIP and the combined ZIP exactly once"
        )

    archives = []
    for artifact in artifacts:
        filename = artifact["file"]
        digest = artifact.get("sha256")
        if not isinstance(digest, str) or not re.fullmatch(r"[0-9a-f]{64}", digest):
            raise ValueError(f"invalid SHA-256 for {filename}")

        path = dist / filename
        if sha256(path) != digest:
            raise ValueError(f"checksum mismatch for {filename}")

        # Reading the directory checks ZIP structure and gives the reporter its file listing.
        with zipfile.ZipFile(path) as archive:
            files = tuple(archive.infolist())
        archives.append(ReleaseArchive(path, digest, files))

    return VerifiedRelease(version, commit, notes, tuple(archives))


def main(argv: list[str] | None = None) -> int:
    """Emit only approved archive paths on stdout; failures go to stderr with a nonzero status."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("dist", type=Path, help="directory containing packaged release assets")
    parser.add_argument("--commit", required=True, help="expected producing commit")
    args = parser.parse_args(argv)

    try:
        release = verify(args.dist, args.commit)
    except (OSError, ValueError, zipfile.BadZipFile) as error:
        print(f"release-artifacts: {error}", file=sys.stderr)
        return 1

    for archive in release.archives:
        print(archive.path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
