#!/usr/bin/env python3
"""Download and install verified Baked QuestieDB releases without a Lua toolchain.

All downloads and extraction checks finish before installation changes begin. The final
merge is not transactional: filesystem failures during copying can leave a partial update.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import re
import shutil
import stat
import sys
import tempfile
from urllib.parse import quote
from urllib.request import urlopen
import zipfile


FLAVORS = ("Vanilla", "TBC", "Wrath", "Cata", "Mists")
ARCHIVE = "QuestieDB-all.zip"
TOCS = {"QuestieDB_%s.toc" % flavor for flavor in FLAVORS}


def download(url: str, destination: Path) -> None:
    """Stream a release asset into the private staging directory."""
    with urlopen(url, timeout=60) as response, destination.open("wb") as output:
        shutil.copyfileobj(response, output)


def sha256(path: Path) -> str:
    """Hash large ZIPs without retaining them in memory."""
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def stage_archive(archive_path: Path, stage: Path) -> None:
    """Extract generated payloads only, rejecting unsafe or duplicate archive paths."""
    seen = set()
    spellings: dict[str, str] = {}

    with zipfile.ZipFile(archive_path) as archive:
        for entry in archive.infolist():
            name = entry.filename.rstrip("/")
            parts = name.split("/")

            mode = stat.S_IFMT(entry.external_attr >> 16)
            if mode not in (0, stat.S_IFREG, stat.S_IFDIR):
                raise ValueError(
                    "%s contains a link or special file: %s" % (archive_path.name, name)
                )

            # Reject Windows aliases and separators on every host, not just during Windows
            # extraction. Never let a ZIP escape the addon or overwrite a clone's .git files.
            if (
                not parts
                or parts[0] != "QuestieDB"
                or any(
                    not part
                    or part.startswith(".")
                    or part.endswith((".", " "))
                    or re.search(r'[<>:"\\|?*\x00-\x1f]', part)
                    or re.fullmatch(r"(?i)(con|prn|aux|nul|com[1-9]|lpt[1-9])(?:\..*)?", part)
                    for part in parts
                )
            ):
                raise ValueError("unsafe archive path: %s" % name)

            # Only release-owned paths may be merged into an existing developer clone.
            relative = PurePosixPath(*parts[1:])
            if len(parts) == 1:
                if not entry.is_dir():
                    raise ValueError("QuestieDB archive root must be a directory")
                continue
            if (
                parts[1] not in ("src", "support", "Types", "icons")
                and str(relative) not in TOCS
                and str(relative) != "CHANGELOG.md"
            ):
                raise ValueError("archive contains non-generated payload: %s" % name)

            # Entries must be distinct even on case-insensitive filesystems.
            if name in seen:
                raise ValueError("duplicate archive entry: %s" % name)
            seen.add(name)
            for length in range(1, len(parts) + 1):
                spelling = "/".join(parts[:length])
                previous = spellings.setdefault(spelling.casefold(), spelling)
                if previous != spelling:
                    raise ValueError(
                        "archive paths differ only by case: %s and %s" % (previous, spelling)
                    )

            target = stage.joinpath(*relative.parts)
            if entry.is_dir():
                target.mkdir(parents=True, exist_ok=True)
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            with archive.open(entry) as source, target.open("wb") as output:
                shutil.copyfileobj(source, output)


def install(addons: Path, tag: str = "latest", repo: str = "Questie/QuestieDB") -> Path:
    """Verify and stage a release, then merge it into AddOns/QuestieDB.

    Files outside the release payload are retained; matching runtime files are replaced.
    The addon root may be a developer's symlink/junction, but descendant links are rejected
    rather than followed during writes.
    """
    # Validate the requested repository and target before downloading anything.
    addons = Path(addons)
    if not addons.is_dir():
        raise ValueError("'%s' is not a directory; point this at Interface/AddOns" % addons)
    if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", repo) or any(
        part in (".", "..") for part in repo.split("/")
    ):
        raise ValueError("repository must be an owner/name on GitHub")
    if not tag:
        raise ValueError("release tag must not be empty")

    base = "https://github.com/%s/releases/" % repo
    base += "latest/download" if tag == "latest" else "download/" + quote(tag, safe="")
    target = (addons / "QuestieDB").resolve()
    if target.exists() and not target.is_dir():
        raise ValueError("install target is not a directory: %s" % target)

    with tempfile.TemporaryDirectory(prefix="questiedb-bootstrap-") as work_dir:
        work = Path(work_dir)

        # The manifest selects one combined archive and its expected checksum.
        print("bootstrap: fetching manifest from %s" % base, flush=True)
        manifest_path = work / "release.json"
        download(base + "/release.json", manifest_path)

        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        if not isinstance(manifest, dict) or not isinstance(manifest.get("questiedb"), dict):
            raise ValueError("release manifest must contain a questiedb object")
        manifest = manifest["questiedb"]
        if not isinstance(manifest.get("artifacts"), list) or not manifest["artifacts"]:
            raise ValueError("manifest listed no artifacts")

        combined = [
            entry
            for entry in manifest["artifacts"]
            if isinstance(entry, dict) and entry.get("file") == ARCHIVE
        ]
        if len(combined) != 1:
            raise ValueError("manifest must list exactly one " + ARCHIVE)

        expected = combined[0].get("sha256")
        if not isinstance(expected, str) or not re.fullmatch(r"[0-9a-f]{64}", expected):
            raise ValueError("manifest contains an invalid SHA-256 for " + ARCHIVE)

        # Downloads and extraction remain private until every safety check passes.
        print(
            "bootstrap: release built from %s, contract version %s"
            % (
                manifest.get("producerCommit", "unknown"),
                manifest.get("contractVersion", "unknown"),
            ),
            flush=True,
        )
        print("bootstrap: downloading %s" % ARCHIVE, flush=True)
        archive = work / ARCHIVE
        download(base + "/" + ARCHIVE, archive)
        if sha256(archive) != expected:
            raise ValueError("checksum mismatch for %s; refusing to install" % ARCHIVE)

        stage = work / "extracted"
        stage.mkdir()
        stage_archive(archive, stage)
        if {path.name for path in stage.glob("QuestieDB_*.toc") if path.is_file()} != TOCS:
            raise ValueError("release does not contain all five generated flavor TOCs")

        # Preflight destination paths as well as ZIP entries. A working clone can contain
        # symlinks; copying through one could modify files outside the requested addon.
        paths = sorted(stage.rglob("*"))
        for source in paths:
            destination = target / source.relative_to(stage)
            if destination.is_symlink() or destination.resolve() != destination:
                raise ValueError("install path traverses a link: %s" % destination)
            if destination.exists() and destination.is_dir() != source.is_dir():
                raise ValueError("install path has the wrong file type: %s" % destination)

        old_tocs = list(target.glob("QuestieDB_*.toc"))
        if any(path.is_dir() for path in old_tocs):
            raise ValueError("a generated TOC path is a directory; refusing to remove it")

        # Installation begins here. The final merge can leave a partial update on I/O failure.
        print("bootstrap: verified and staged; installing into %s" % target, flush=True)
        target.mkdir(parents=True, exist_ok=True)
        for path in old_tocs:
            path.unlink()

        for source in paths:
            destination = target / source.relative_to(stage)
            if source.is_dir():
                destination.mkdir(parents=True, exist_ok=True)
            else:
                shutil.copyfile(source, destination)

    print("bootstrap: installed all five flavors in Baked mode", flush=True)
    print(
        "bootstrap: Source mode needs the clone's original runtime files as well as removal of generated TOCs",
        flush=True,
    )
    return target


def main(argv: list[str] | None = None) -> int:
    """Keep the shell and PowerShell launchers free of installation policy."""
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("addons", type=Path, help="Interface/AddOns directory")
    parser.add_argument(
        "tag", nargs="?", default="latest", help="release tag, or latest stable (default)"
    )
    parser.add_argument("--repo", default=os.environ.get("QUESTIEDB_REPO") or "Questie/QuestieDB")
    args = parser.parse_args(argv)

    try:
        install(args.addons, args.tag, args.repo)
    except (OSError, ValueError, zipfile.BadZipFile, RuntimeError) as error:
        print("bootstrap: %s" % error, file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
