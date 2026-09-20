#!/usr/bin/env python3
"""Release workflow policy, using the GitHub Actions environment and authenticated gh CLI.

Run from the repository root: release.py preflight | publish
The workflow owns triggers, permissions, concurrency, and the quality gates. This script
selects releases and publishes their verified artifacts; it never builds them.
"""

from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import zipfile

from release_artifacts import verify


RELEASE_QUERY = """
query($owner:String!, $repo:String!, $tag:String!, $ref:String!) {
  repository(owner:$owner, name:$repo) {
    release(tagName:$tag) { databaseId }
    ref(qualifiedName:$ref) { name }
  }
}
"""


def gh_output(*args: str) -> str:
    """Read CLI output while leaving GitHub's error diagnostics visible."""
    return subprocess.check_output(["gh", *args], text=True).strip()


def gh(*args: str) -> None:
    """Run a publication command without hiding its progress or failure."""
    subprocess.run(["gh", *args], check=True)


def require_default_branch() -> None:
    if os.environ["GITHUB_REF"] != "refs/heads/" + os.environ["DEFAULT_BRANCH"]:
        raise ValueError("Releases must run from the default branch.")


def release_state(repository: str, tag: str, full_release: bool, override: bool) -> dict:
    """Read draft-aware GitHub state and reject an unapproved version collision.

    Preflight and publication call the same check. Publication repeats it under the
    workflow's concurrency lock because another run may publish while this one builds.
    """
    owner, repo = repository.split("/", 1)
    state = json.loads(
        gh_output(
            "api",
            "graphql",
            "-f",
            f"owner={owner}",
            "-f",
            f"repo={repo}",
            "-f",
            f"tag={tag}",
            "-f",
            f"ref=refs/tags/{tag}",
            "-f",
            f"query={RELEASE_QUERY}",
            "--jq",
            ".data.repository",
        )
    )
    if not isinstance(state, dict):
        raise ValueError("GitHub did not return repository release state.")

    if (
        full_release
        and not override
        and (state.get("release") is not None or state.get("ref") is not None)
    ):
        raise ValueError(f"{tag} already exists. Bump ## Version or explicitly enable override.")
    return state


def preflight() -> None:
    """Select the workflow tag and check publication state unless this is a rehearsal."""
    require_default_branch()
    full_release = os.environ["QUESTIEDB_RELEASE"] == "true"
    override = os.environ["RELEASE_OVERRIDE"] == "true"
    if override and not full_release:
        raise ValueError("override applies only to full releases.")

    # Keep the maintained version's parsing rules in the generator, not a Python copy.
    version = subprocess.check_output(
        ["lua5.1", "-e", 'print(dofile("generator/version.lua").read("QuestieDB.toc"))'],
        text=True,
    ).strip()
    tag = f"v{version}" if full_release else "preview"
    with Path(os.environ["GITHUB_OUTPUT"]).open("a", encoding="utf-8") as output:
        output.write(f"tag={tag}\n")

    if os.environ["DRY_RUN"] == "true":
        print(f"Dry run: building {tag} without changing tags or releases.")
        return

    release_state(os.environ["GITHUB_REPOSITORY"], tag, full_release, override)


def publish() -> None:
    """Publish the checked handoff, preserving the manifest-last replacement protocol."""
    # The workflow already skips this command for dry runs; direct calls must not publish one.
    if os.environ["DRY_RUN"] == "true":
        raise ValueError("Dry runs cannot publish tags or releases.")

    commit = os.environ["GITHUB_SHA"]
    if subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip() != commit:
        raise ValueError("The checkout does not match GITHUB_SHA.")
    require_default_branch()

    repository = os.environ["GITHUB_REPOSITORY"]
    tag = os.environ["TAG"]
    full_release = os.environ["QUESTIEDB_RELEASE"] == "true"
    override = os.environ["RELEASE_OVERRIDE"] == "true"
    dist = Path(".out/dist")

    # Use exactly the same verifier and ZIP inventory as the dry-run report.
    release = verify(dist, commit)
    state = release_state(repository, tag, full_release, override)
    release_id = (state.get("release") or {}).get("databaseId")
    has_tag = state.get("ref") is not None

    if release_id is not None:
        immutable = gh_output(
            "api", f"repos/{repository}/releases/{release_id}", "--jq", ".immutable // false"
        )
        if immutable == "true":
            raise ValueError(f"{tag} is immutable on GitHub; override cannot replace it.")

    # A slow preview must not roll the tag back after a newer build has already published.
    if tag == "preview" and has_tag:
        current = gh_output(
            "api", f"repos/{repository}/commits/refs%2Ftags%2F{tag}", "--jq", ".sha"
        )
        status = gh_output(
            "api", f"repos/{repository}/compare/{current}...{commit}", "--jq", ".status"
        )
        if status == "behind":
            print("A newer preview is already published; skipping this build.")
            return
        if status not in ("ahead", "identical"):
            raise ValueError("Preview history diverged. Resolve its tag before publishing.")

    title = (
        f"QuestieDB {tag[1:]}"
        if full_release
        else "Unstable Pre-Release Development Build (master-branch)"
    )
    prerelease = "false" if full_release else "true"
    latest = "true" if full_release else "false"
    notes = str(dist / "RELEASE_NOTES.md")

    if tag == "preview" and release_id is not None:
        # A new release record gives each preview a fresh publication date. Keep the tag
        # for ancestry checks and move it only after the replacement assets are uploaded.
        gh("release", "delete", tag, "--yes")
        release_id = None

    if release_id is None:
        # New releases, including recreated previews, stay drafts until all assets upload.
        # Let GitHub create a missing tag rather than racing separate ref creation.
        gh(
            "release",
            "create",
            tag,
            "--target",
            commit,
            "--draft",
            "--title",
            title,
            "--notes-file",
            notes,
        )

    # Stable overrides stay public, so retain their old manifest until ZIP uploads and any
    # tag move finish. Recreated previews remain unpublished drafts through these steps.
    gh(
        "release",
        "upload",
        tag,
        *[str(archive.path) for archive in release.archives],
        notes,
        "--clobber",
    )
    if has_tag:
        gh(
            "api",
            f"repos/{repository}/git/refs/tags/{tag}",
            "--method",
            "PATCH",
            "-f",
            f"sha={commit}",
            "-F",
            "force=true",
        )
    gh("release", "upload", tag, str(dist / "release.json"), "--clobber")
    gh(
        "release",
        "edit",
        tag,
        "--draft=false",
        "--target",
        commit,
        "--title",
        title,
        "--notes-file",
        notes,
        f"--prerelease={prerelease}",
        f"--latest={latest}",
    )


def main(argv: list[str] | None = None) -> int:
    """Keep workflow failures visible as Actions annotations and nonzero exit statuses."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("command", choices=("preflight", "publish"))
    args = parser.parse_args(argv)

    try:
        if shutil.which("gh") is None:
            raise ValueError(
                "GitHub CLI (gh) is required; install it from https://cli.github.com/ and add it to PATH."
            )

        if args.command == "preflight":
            preflight()
        else:
            publish()
    except (
        OSError,
        ValueError,
        KeyError,
        subprocess.CalledProcessError,
        zipfile.BadZipFile,
    ) as error:
        print(f"::error::{error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
