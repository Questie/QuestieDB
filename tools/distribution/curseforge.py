#!/usr/bin/env python3
"""Upload a published stable release's per-flavor ZIPs to CurseForge.

Usage: python3 tools/distribution/curseforge.py vX.Y.Z DIST [--dry-run]
DIST holds release.json, RELEASE_NOTES.md, and the ZIPs downloaded from that GitHub release.
Run from a clone whose origin has the release tag. Requires git, curl, and CF_API_TOKEN;
CF_PROJECT_ID selects the project (default: QuestieDB).

Mirrors Questie's upload-cf.sh: the same CurseForge game versions, and a remote
curse/<tag>/<flavor> tag reserved before each upload so no flavor is uploaded twice.
Reruns skip reserved flavors. A failed upload keeps its reservation; check CurseForge
before deleting it to retry. --dry-run prints the uploads without reserving or sending.
"""

from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import zipfile

from release_artifacts import verify

API = "https://wow.curseforge.com/api"
DEFAULT_PROJECT_ID = "1696795"
OTHER_COMMIT = (
    "was reserved for another commit; CurseForge still has those files. "
    "Publish a new version instead of overriding an uploaded release."
)

# CurseForge game version IDs, kept equal to Questie's upload-cf.sh. Questie publishes
# no Cata build, so neither does QuestieDB.
GAME_VERSIONS = {
    "Vanilla": 16630,
    "Forever": 17053,
    "TBC": 16533,
    "Wrath": 16785,
    "Mists": 16168,
}


def changelog(notes: str) -> str:
    """Keep only the changes; download, installation, and checksum sections serve GitHub ZIPs."""
    return notes.split("\n## Download", 1)[0].rstrip() + "\n"


def git(*args: str) -> str:
    return subprocess.run(
        ["git", *args], check=True, capture_output=True, text=True
    ).stdout.strip()


def reserve(commit: str, marker: str) -> bool:
    """Create the remote marker tag. Only a newly created ref grants permission to upload."""
    result = git("push", "--porcelain", "--no-follow-tags", "origin", f"{commit}:refs/tags/{marker}")
    return any(line.startswith("*") for line in result.splitlines())


def upload_file(project: str, path: Path, metadata: dict) -> None:
    subprocess.run(
        [
            "curl",
            "-sS",
            "--fail-with-body",
            "--connect-timeout",
            "30",
            "--max-time",
            "900",
            "-H",
            f"X-API-TOKEN: {os.environ['CF_API_TOKEN']}",
            "--form-string",
            f"metadata={json.dumps(metadata)}",
            "-F",
            f"file=@{path}",
            f"{API}/projects/{project}/upload-file",
        ],
        check=True,
        capture_output=True,
        text=True,
    )


def upload(tag: str, dist: Path, dry_run: bool) -> None:
    if not re.fullmatch(r"v\d+\.\d+\.\d+", tag):
        raise ValueError("Only stable vX.Y.Z releases go to CurseForge")
    if not dry_run and not os.environ.get("CF_API_TOKEN"):
        raise ValueError("CF_API_TOKEN is required")
    project = os.environ.get("CF_PROJECT_ID") or DEFAULT_PROJECT_ID

    # Check the remote directly so stale local tags cannot mislead us.
    git("fetch", "--tags", "origin")
    if not git("ls-remote", "--tags", "origin", f"refs/tags/{tag}"):
        raise ValueError(f"Release tag {tag} does not exist on origin")
    commit = git("rev-parse", f"refs/tags/{tag}^{{commit}}")

    release = verify(dist, commit)
    if f"v{release.version}" != tag:
        raise ValueError(f"Release manifest version {release.version} does not match {tag}")
    notes = changelog(release.notes)

    # Refuse before any upload when another commit already reserved a flavor of this release.
    for line in git("ls-remote", "--tags", "origin", f"refs/tags/curse/{tag}/*").splitlines():
        sha, ref = line.split()
        if sha != commit:
            raise ValueError(f"{ref.removeprefix('refs/tags/')} {OTHER_COMMIT}")

    for flavor, game_version in GAME_VERSIONS.items():
        filename = f"QuestieDB-{flavor}.zip"
        marker = f"curse/{tag}/{flavor}"
        metadata = {
            "displayName": f"{tag} ({flavor})",
            "releaseType": "release",
            "changelog": notes,
            "changelogType": "markdown",
            "gameVersions": [game_version],
        }
        if dry_run:
            print(f"Dry run: would upload {filename} with game version {game_version}")
            continue
        existing = git("ls-remote", "--tags", "origin", f"refs/tags/{marker}")
        if existing:
            if existing.split()[0] != commit:
                raise ValueError(f"{marker} {OTHER_COMMIT}")
            print(f"{marker} already exists; skipping {filename}")
            continue
        if not reserve(commit, marker):
            raise ValueError(f"{marker} was reserved by another run; refusing to upload {filename}")
        try:
            upload_file(project, dist / filename, metadata)
        except subprocess.CalledProcessError as error:
            raise ValueError(
                f"Uploading {filename} failed: {error.stdout or error.stderr}\n"
                "Check CurseForge before retrying. Only if the file was not accepted, remove "
                f"the reservation with `git push origin --delete {marker}` and rerun."
            ) from error
        print(f"Uploaded {filename}")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("tag", help="published stable release tag, e.g. v1.0.9")
    parser.add_argument("dist", type=Path, help="directory containing that release's assets")
    parser.add_argument("--dry-run", action="store_true")
    args = parser.parse_args(argv)

    try:
        upload(args.tag, args.dist, args.dry_run)
    except subprocess.CalledProcessError as error:
        print(f"curseforge: {' '.join(error.cmd[:2])} failed: {error.stderr}", file=sys.stderr)
        return 1
    except (OSError, ValueError, zipfile.BadZipFile) as error:
        print(f"curseforge: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
