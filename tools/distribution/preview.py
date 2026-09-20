#!/usr/bin/env python3
"""Inspect packaged release artifacts without regenerating them or contacting GitHub.

Usage: python3 tools/distribution/preview.py .out/dist [--commit SHA] [--summary PATH]
Writes DRY_RUN.md beside the release assets; --summary also writes an Actions job summary.
"""

from __future__ import annotations

import argparse
from html import escape
from pathlib import Path
import sys
import zipfile

from release_artifacts import verify


SUMMARY_LIMIT = 1024 * 1024
INTRODUCTION = (
    "# Release dry run\n\n"
    "No tags or GitHub releases were created or changed.\n\n"
    "Download **release-dist** from this run's Actions artifacts for the actual ZIPs, "
    "`release.json`, and `RELEASE_NOTES.md`. "
    "The **release-dry-run-preview** artifact contains this full report as `DRY_RUN.md`.\n\n"
    "The release links in the description below are previews, not links to these artifacts. "
    "They may not exist yet or may point to an older published release.\n"
)


def render(dist: Path, expected_commit: str | None = None) -> str:
    """Verify the release handoff and report its ZIP layout and exact release description."""
    release = verify(dist, expected_commit)

    sections = [
        INTRODUCTION.rstrip(),
        f"- Addon version: `{release.version}`\n- Producing commit: `{release.producer_commit}`",
        "## ZIP contents\n\nExpand an archive to inspect its paths and uncompressed file sizes.",
    ]
    for archive in release.archives:
        listing = "\n".join(
            f"{entry.filename}  ({entry.file_size:,} bytes)"
            for entry in sorted(archive.files, key=lambda entry: entry.filename)
        )
        sections.append(
            f"<details>\n<summary>{escape(archive.path.name)}</summary>\n\n"
            f"ZIP size: {archive.path.stat().st_size:,} bytes. SHA-256: `{archive.sha256}`\n\n"
            f"<pre>{escape(listing)}</pre>\n\n</details>"
        )

    # Reuse the packaged Markdown verbatim, not a second release-note renderer.
    sections.append("## GitHub release description\n\n---\n\n" + release.notes)
    return "\n\n".join(sections)


def main(argv: list[str] | None = None) -> int:
    """Write the full report, with a short fallback when Actions' summary limit is exceeded."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("dist", type=Path, help="directory containing packaged release assets")
    parser.add_argument("--commit", help="expected producing commit for the downloaded handoff")
    parser.add_argument("--summary", type=Path, help="also write a GitHub Actions step summary")
    args = parser.parse_args(argv)

    try:
        report = render(args.dist, args.commit)
        output = args.dist / "DRY_RUN.md"
        output.write_text(report, encoding="utf-8")

        if args.summary is not None:
            summary = report
            if len(report.encode("utf-8")) > SUMMARY_LIMIT:
                summary = INTRODUCTION + (
                    "\nThe full preview exceeds GitHub's job-summary size limit. "
                    "Download `DRY_RUN.md` from **release-dry-run-preview** to read it.\n"
                )
            args.summary.write_text(summary, encoding="utf-8")

        print(f"wrote {output}")
    except (OSError, ValueError, zipfile.BadZipFile) as error:
        print(f"preview: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
