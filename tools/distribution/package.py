#!/usr/bin/env python3
"""Package generated TOCs using only Python's standard library.

Usage: questiedb.sh package [Vanilla|TBC|Wrath|Cata|Mists|all]
       questiedb.ps1 package [Vanilla|TBC|Wrath|Cata|Mists|all]
Run from any directory. Outputs replace this checkout's .out/dist and .out/stage.
Generation remains dependency-free Lua; packaging also needs Lua 5.1 for the existing
Static Correction stripping and behavior-parity check.
"""

from __future__ import annotations

from dataclasses import dataclass
from datetime import datetime, timezone
import hashlib
import json
import os
import platform
from pathlib import Path, PurePosixPath
import re
import shutil
import subprocess
import sys
from typing import TypedDict
import zipfile

import release_notes


ROOT = Path(__file__).resolve().parents[2]
FLAVORS = ("Vanilla", "TBC", "Wrath", "Cata", "Mists")
ZERO_COMMIT = "0" * 40


@dataclass(frozen=True)
class FlavorSource:
    """A generated TOC and its runtime files and assets, relative to the checkout."""

    flavor: str
    toc: Path
    files: tuple[Path, ...]
    questie_commit: str
    version: str
    contract_version: int


class Artifact(TypedDict):
    flavor: str
    file: str
    sha256: str
    bytes: int
    rawBytes: int


def find_lua() -> str:
    """Honor LUA, then prefer a matching bundle before checking PATH."""
    bundled = None
    if sys.platform == "win32" and platform.machine().lower() in ("x86_64", "amd64"):
        bundled = ROOT / "tools/lua-binary/lua.exe"
    elif sys.platform.startswith("linux") and platform.machine().lower() in ("x86_64", "amd64"):
        bundled = ROOT / "tools/lua-binary/linux-x64/lua"

    candidates = (
        [os.environ["LUA"]]
        if os.environ.get("LUA")
        else (([str(bundled)] if bundled else []) + ["lua5.1", "lua", "luajit"])
    )
    for candidate in candidates:
        executable = shutil.which(candidate)
        if executable:
            result = subprocess.run(
                [executable, "-e", "io.write(_VERSION)"], capture_output=True, text=True
            )
            if result.returncode == 0 and result.stdout == "Lua 5.1":
                return str(Path(executable).resolve())
    raise ValueError("Lua 5.1 is required; install it or set LUA=/path/to/lua5.1")


def read_source(root: Path, flavor: str) -> FlavorSource:
    """Read file paths and release headers without materializing the metadata payload."""
    toc = Path("QuestieDB_%s.toc" % flavor)
    files = []
    headers: dict[str, str] = {}

    if not (root / toc).is_file():
        raise ValueError("%s is not generated; generate every requested flavor first" % toc)

    with (root / toc).open(encoding="utf-8") as source:
        for line in source:
            line = line.strip()
            if line.startswith("##") and ":" in line:
                key, value = line[2:].split(":", 1)
                key = key.strip().lower()

                if key in ("version", "x-contract-version", "x-questie-commit"):
                    if key in headers:
                        raise ValueError("%s repeats metadata field: %s" % (toc, key))
                    headers[key] = value.strip()

                if key == "icontexture":
                    # Metadata assets are not TOC load entries. Ship only addon-owned textures,
                    # not built-in game textures or the rest of the artwork directory.
                    texture = value.strip().replace("\\", "/")
                    prefix = "Interface/AddOns/QuestieDB/"
                    if texture.startswith(prefix):
                        line = texture[len(prefix) :]

            if not line or line.startswith("#"):
                continue

            relative = PurePosixPath(line.replace("\\", "/"))
            if relative.is_absolute() or ".." in relative.parts:
                raise ValueError("%s lists an unsafe runtime path: %s" % (toc, line))
            path = Path(relative)
            if not (root / path).is_file():
                raise ValueError("%s lists a missing runtime file: %s" % (toc, path))
            files.append(path)

    # Release identity comes from the Baked TOC, not the current Source TOC.
    questie_commit = headers.get("x-questie-commit", ZERO_COMMIT)
    if not re.fullmatch(r"[0-9a-f]{40}", questie_commit):
        raise ValueError("%s has an invalid X-QUESTIE-COMMIT" % toc)

    version = headers.get("version", "")
    if not re.fullmatch(
        r"(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)(?:-dev\.[0-9a-f]{7})?", version
    ):
        raise ValueError("%s needs a canonical Version (X.X.X or X.X.X-dev.<7 hex digits>)" % toc)

    contract = headers.get("x-contract-version", "")
    if not re.fullmatch(r"[1-9][0-9]*", contract):
        raise ValueError("%s needs a positive integer X-Contract-Version" % toc)
    if Path("src/config.lua") not in files:
        raise ValueError("%s must load src/config.lua for its runtime contract" % toc)

    return FlavorSource(flavor, toc, tuple(files), questie_commit, version, int(contract))


def producer_commit(root: Path) -> str:
    """Preserve recognizable provenance when packaging outside a Git checkout."""
    try:
        result = subprocess.run(
            ["git", "-C", str(root), "rev-parse", "HEAD"], capture_output=True, text=True
        )
    except FileNotFoundError:
        return ZERO_COMMIT
    commit = result.stdout.strip()
    return (
        commit if result.returncode == 0 and re.fullmatch(r"[0-9a-f]{40}", commit) else ZERO_COMMIT
    )


def sha256(path: Path) -> str:
    """Hash archives without materializing the combined download in memory."""
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def build_zip(
    root: Path,
    sources: list[FlavorSource],
    types: list[Path],
    lua: str,
    flavor: str,
    changelog: str,
) -> Artifact:
    """Stage the selected TOCs' union, strip only staged copies, and check the ZIP."""
    stage = root / ".out/stage"
    if stage.exists():
        shutil.rmtree(stage)

    addon = stage / "QuestieDB"
    addon.mkdir(parents=True)

    # Shared runtime paths come from one checkout, so the combined ZIP is their union.
    files = dict.fromkeys(path for source in sources for path in (source.toc, *source.files))
    for path in files:
        target = addon / path
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy(root / path, target)

    # Consumer-only files are shipped alongside the addon, never loaded by its TOCs.
    (addon / "Types").mkdir()
    for path in types:
        shutil.copy(path, addon / "Types" / path.name)
    (addon / "CHANGELOG.md").write_text(changelog, encoding="utf-8")

    subprocess.run([lua, "tools/distribution/strip-static.lua", str(addon)], cwd=root, check=True)

    filename = "QuestieDB-%s.zip" % flavor
    archive_path = root / ".out/dist" / filename

    # Sorted paths stabilize entry ordering. ZIP timestamps are not a cross-build byte contract;
    # determinism gates cover generated TOCs, and the manifest hashes the finished archives.
    with zipfile.ZipFile(
        archive_path,
        "w",
        compression=zipfile.ZIP_DEFLATED,
        compresslevel=9,
        strict_timestamps=False,
    ) as archive:
        archive.write(addon, "QuestieDB/")
        for path in sorted(addon.rglob("*")):
            archive.write(path, path.relative_to(stage).as_posix())

    with zipfile.ZipFile(archive_path) as archive:
        names = set(archive.namelist())
        for path in types:
            expected = "QuestieDB/Types/" + path.name
            if expected not in names:
                raise ValueError("%s is missing %s" % (filename, expected))

    size = archive_path.stat().st_size
    raw = sum((root / source.toc).stat().st_size for source in sources)
    print(
        "packaged %s (%d MB zipped, %d MB raw)"
        % (archive_path.relative_to(root), size // 1048576, raw // 1048576),
        flush=True,
    )
    return {
        "flavor": "All" if flavor == "all" else flavor,
        "file": filename,
        "sha256": sha256(archive_path),
        "bytes": size,
        "rawBytes": raw,
    }


def package(root: Path, flavors: list[str]) -> None:
    """Preflight inputs before clearing output, then publish a local manifest last."""
    # Complete input and tool checks before replacing any previous local output.
    if (
        not flavors
        or len(set(flavors)) != len(flavors)
        or any(flavor not in FLAVORS for flavor in flavors)
    ):
        raise ValueError("choose distinct flavors: Vanilla TBC Wrath Cata Mists, or all")

    try:
        import zlib  # Packaging needs Python's standard compression module before clearing outputs.
    except ImportError as error:
        raise ValueError("Python's standard zlib module is required for packaging") from error

    lua = find_lua()
    sources = [read_source(root, flavor) for flavor in flavors]

    questie_commit = os.environ.get("QUESTIE_COMMIT") or sources[0].questie_commit
    if any(source.questie_commit != questie_commit for source in sources):
        raise ValueError("TOCs have different legacy Questie baselines; regenerate them together")

    types = sorted((root / "src/types").glob("*.t.lua"))
    if not types:
        raise ValueError("src/types has no LuaLS declarations to package")

    # Execute the same validated configuration shipped in every archive, not a parallel
    # regex interpretation of Lua assignments. Baked TOCs may be older than this checkout.
    result = subprocess.run(
        [
            lua,
            "-e",
            'local c = dofile("src/config.lua"); '
            'io.write(c.contractVersion, "\\n", c.minSupportedContract, "\\n")',
        ],
        cwd=root,
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise ValueError("Cannot load runtime contract: " + result.stderr.strip())

    values = result.stdout.splitlines()
    if len(values) != 2 or any(not re.fullmatch(r"[1-9][0-9]*", value) for value in values):
        raise ValueError(
            "src/config.lua must provide positive integer contractVersion and minSupportedContract"
        )
    contract, minimum_contract = map(int, values)
    if minimum_contract > contract:
        raise ValueError("minSupportedContract must not exceed contractVersion")
    if any(source.contract_version != contract for source in sources):
        raise ValueError(
            "TOC X-Contract-Version differs from the packaged runtime; regenerate the TOCs"
        )

    version = sources[0].version
    if any(source.version != version for source in sources):
        raise ValueError("TOCs have different addon versions; regenerate them together")

    # Collect provenance and changes once, shared by every archive and the release notes.
    epoch = os.environ.get("SOURCE_DATE_EPOCH")
    built = (
        datetime.fromtimestamp(int(epoch), timezone.utc)
        if epoch is not None
        else datetime.now(timezone.utc)
    )
    commit = producer_commit(root)
    repository_url = "https://github.com/" + os.environ.get(
        "GITHUB_REPOSITORY", "Questie/QuestieDB"
    )
    changes = release_notes.changelog(root, version, commit, repository_url)
    changelog = f"# QuestieDB {version}\n\n" + changes.markdown

    # Output replacement begins here. Later failures can leave partial packages.
    dist = root / ".out/dist"
    if dist.exists():
        shutil.rmtree(dist)
    dist.mkdir(parents=True)

    artifacts = [
        build_zip(root, [source], types, lua, source.flavor, changelog) for source in sources
    ]
    if len(sources) == len(FLAVORS):
        artifacts.append(build_zip(root, sources, types, lua, "all", changelog))

    shutil.rmtree(root / ".out/stage")

    # Keep the potentially long changelog last so metadata stays easy to inspect.
    manifest = {
        "producerCommit": commit,
        "questieCommit": questie_commit,
        "version": version,
        "contractVersion": contract,
        "minSupportedContract": minimum_contract,
        "builtAt": built.strftime("%Y-%m-%dT%H:%M:%SZ"),
        "nolib": False,
        "artifacts": artifacts,
        "changelog": changes.entries,
    }
    (dist / "release.json").write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    (dist / "RELEASE_NOTES.md").write_text(
        release_notes.render(
            version,
            commit,
            questie_commit,
            minimum_contract,
            contract,
            [artifact["file"] for artifact in artifacts],
            changes.markdown,
            repository_url,
        ),
        encoding="utf-8",
    )
    print("wrote .out/dist/release.json", flush=True)


def main() -> int:
    """Keep failures actionable without hiding the stripper's own diagnostics."""
    args = sys.argv[1:]
    if args in (["--help"], ["-h"]):
        print(__doc__)
        return 0

    try:
        package(ROOT, list(FLAVORS) if not args or args == ["all"] else args)
    except (
        OSError,
        ValueError,
        OverflowError,
        subprocess.CalledProcessError,
        zipfile.BadZipFile,
    ) as error:
        print("package: %s" % error, file=sys.stderr)
        return 1

    return 0


if __name__ == "__main__":
    sys.exit(main())
