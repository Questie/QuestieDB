"""Install a missing Questie/dbc source artifact, never refresh existing databases.

Adapted from dbc/download.py and dbc/dbc/release_assets.py's manifest/source
contract. Raw archives and release publishing intentionally do not belong here.
"""
from __future__ import annotations

import hashlib
import json
import lzma
import os
from pathlib import Path
import re
import shutil
import sqlite3
import subprocess
import tempfile
from urllib.parse import quote, urlparse
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DATABASE = ROOT / ".cache/dbc/dbc-source.db"
REPOSITORY = "Questie/dbc"
API = "https://api.github.com/repos/" + REPOSITORY + "/releases/"
CHUNK_SIZE = 1024 * 1024


def open_url(url: str):
    """Open an HTTPS release resource with a bounded socket timeout."""
    if urlparse(url).scheme != "https":
        raise ValueError("DBC release resources must use HTTPS")
    request = Request(url, headers={"User-Agent": "QuestieDB-DBC"})
    return urlopen(request, timeout=60)


def read_json(url: str) -> dict:
    """Read the small release/manifest document, not the source database payload."""
    with open_url(url) as response:
        data = json.load(response)
    if not isinstance(data, dict):
        raise ValueError("Invalid DBC release metadata")
    return data


def should_use_gh() -> bool:
    """Use the existing GitHub CLI login for private releases, as the DBC downloader does."""
    try:
        return subprocess.run(["gh", "auth", "status"], stdout=subprocess.DEVNULL,
                              stderr=subprocess.DEVNULL, timeout=15).returncode == 0
    except (OSError, subprocess.TimeoutExpired):
        return False


def gh(arguments: list[str], capture: bool = False) -> str:
    """Keep release metadata small in memory; source artifacts download straight to disk."""
    try:
        result = subprocess.run(["gh", *arguments], stdout=subprocess.PIPE if capture else subprocess.DEVNULL,
                                stderr=subprocess.PIPE, text=True, check=True, timeout=300)
        return result.stdout or ""
    except (OSError, subprocess.SubprocessError) as error:
        detail = getattr(error, "stderr", None) or str(error)
        raise ValueError("GitHub DBC download failed: " + str(detail)) from error


def validate_database(path: Path, source_build: str, target_build: str) -> None:
    """Check identity/schema and required builds without integrity-scanning all data."""
    with path.open("rb") as source:
        if source.read(16) != b"SQLite format 3\x00":
            raise ValueError("Not a SQLite database: " + str(path))
    conn = sqlite3.connect(path.resolve().as_uri() + "?mode=ro", uri=True)
    try:
        tables = {row[0] for row in conn.execute("SELECT name FROM sqlite_master WHERE type='table'")}
        required = {"_build", "_table_build", "ui_map", "ui_map_assignment", "area_table"}
        if not required.issubset(tables):
            raise ValueError("DBC database lacks tables: " + ", ".join(sorted(required - tables)))
        for build in (source_build, target_build):
            if not conn.execute("SELECT 1 FROM _build WHERE build=?", (build,)).fetchone():
                raise ValueError("DBC database does not contain required build " + build)
    finally:
        conn.close()


def ensure_database(path: Path, source_build: str, target_build: str,
                    tag: str = None) -> dict:
    """Use a local database, or download/verify/install one when the path is absent.

    Existing invalid databases fail without replacement or network requests.
    Installation uses a same-filesystem hard link to publish a complete file
    atomically without overwriting a database installed concurrently.
    """
    path = Path(path).absolute()
    for component in (path, *path.parents):
        if component.is_symlink():
            raise ValueError("Refusing symlinked DBC cache path: " + str(component))
    if path.exists():
        if not path.is_file():
            raise ValueError("DBC cache is not a regular file: " + str(path))
        validate_database(path, source_build, target_build)
        return {"origin": "existing-local", "path": str(path), "release_tag": None}

    # Resolve one release once; both assets must come from that exact release.
    authenticated = should_use_gh()
    release_suffix = "tags/" + quote(tag, safe="") if tag else "latest"
    release = (json.loads(gh(["api", "repos/" + REPOSITORY + "/releases/" + release_suffix], capture=True))
               if authenticated else read_json(API + release_suffix))
    if not isinstance(release, dict):
        raise ValueError("Invalid DBC release metadata")
    actual_tag = release.get("tag_name")
    if not isinstance(actual_tag, str) or not actual_tag or (tag is not None and tag != actual_tag):
        raise ValueError("DBC release tag does not match the requested release")
    release_assets = release.get("assets")
    if not isinstance(release_assets, list):
        raise ValueError("DBC release has no asset list")
    assets = {}
    for asset in release_assets:
        if not isinstance(asset, dict) or not isinstance(asset.get("name"), str):
            raise ValueError("Invalid DBC release asset")
        name = asset["name"]
        if name in assets:
            raise ValueError("Duplicate DBC release asset: " + str(name))
        assets[name] = asset.get("browser_download_url")
    if not assets.get("manifest.json"):
        raise ValueError("DBC release has no manifest.json asset")
    manifest = (json.loads(gh(["release", "download", "--repo", REPOSITORY, "--pattern", "manifest.json",
                              "--output", "-", "--", actual_tag], capture=True))
                if authenticated else read_json(assets["manifest.json"]))
    if not isinstance(manifest, dict):
        raise ValueError("Invalid DBC manifest")
    if manifest.get("tag", actual_tag) != actual_tag:
        raise ValueError("DBC manifest tag differs from resolved release")
    artifacts = manifest.get("artifacts")
    if not isinstance(artifacts, dict) or not isinstance(artifacts.get("source"), dict):
        raise ValueError("DBC manifest has no source artifact")
    info = artifacts["source"]
    filename, expected = info.get("filename"), info.get("sha256")
    if filename != "dbc-source.db.xz" or not assets.get(filename):
        raise ValueError("DBC release lacks the expected dbc-source.db.xz artifact")
    if not isinstance(expected, str) or not re.fullmatch(r"[0-9a-fA-F]{64}", expected):
        raise ValueError("DBC source manifest lacks a valid SHA-256 checksum")

    # Download and authenticate compressed bytes before decompressing. All partial
    # files stay private to the temporary directory and disappear on failure.
    path.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix=".dbc-download-", dir=str(path.parent)) as temporary:
        archive = Path(temporary) / filename
        if authenticated:
            gh(["release", "download", "--repo", REPOSITORY, "--pattern", filename,
                "--output", str(archive), "--", actual_tag])
        else:
            with open_url(assets[filename]) as response, archive.open("wb") as output:
                shutil.copyfileobj(response, output, CHUNK_SIZE)
        digest = hashlib.sha256()
        with archive.open("rb") as source:
            for block in iter(lambda: source.read(CHUNK_SIZE), b""):
                digest.update(block)
        actual = digest.hexdigest()
        if actual != expected.lower():
            raise ValueError("DBC source SHA-256 mismatch: expected %s, got %s" % (expected, actual))
        database = Path(temporary) / "dbc-source.db"
        try:
            with lzma.open(archive, "rb") as source, database.open("wb") as output:
                shutil.copyfileobj(source, output, CHUNK_SIZE)
        except (lzma.LZMAError, EOFError) as error:
            raise ValueError("Invalid compressed DBC source artifact: " + str(error)) from error
        validate_database(database, source_build, target_build)
        # os.replace would overwrite a concurrent install. link fails if any file
        # appeared after the initial absence check, leaving that file untouched.
        os.link(str(database), str(path))
    return {"origin": "downloaded", "path": str(path), "repository": REPOSITORY,
            "release_tag": actual_tag, "artifact": filename, "artifact_sha256": actual}
