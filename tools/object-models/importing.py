"""Read one source and merge its values into the rows of sources.tsv.

A source is a CSV (objectId, name, and displayId or fileDataId), a CMaNGOS release database,
or a scraper-questie raw cache. None of them is needed for Generation or tests.
"""
from __future__ import annotations

from collections import Counter, defaultdict
import csv
from dataclasses import dataclass, field
import json
from pathlib import Path
import re
import sqlite3
from typing import Dict, Iterator

from models import FILE_ID_SOURCES, FLAVORS, SOURCE_ORDER, SOURCES, Display, Displays, ObjectRow

# SkyFire fills these in where it has no data: a pebble, a purple brazier and a crate.
# AllTheThings contradicts nearly all of them, while SkyFire's other displays agree with it.
SKYFIRE_PLACEHOLDERS = frozenset({299, 474, 2350})
SKYFIRE_NO_NAME = "unkname"

# Emulators number 207 decorations 19392-19665 by subtracting this from the object ID. Clients
# use those displays for unrelated models: 19519 Human Statue would be a goblin totem.
INVENTED_DISPLAY_OFFSET = 10000

# What a file must say about itself to be imported as a source, so mixed-up files are refused.
CMANGOS_REPOSITORIES = {
    "cmangos-classic": "cmangos/classic-db", "cmangos-tbc": "cmangos/tbc-db", "cmangos-wotlk": "cmangos/wotlk-db",
}
WOWHEAD_PATHS = {
    "wowhead-classic": "classic", "wowhead-tbc": "tbc", "wowhead-wotlk": "wotlk", "wowhead-cata": "cata",
    "wowhead-mop": "mop-classic", "wowhead-forever": "forever",
}


@dataclass(frozen=True)
class Claim:
    value: int
    name: str

    def __post_init__(self) -> None:
        if type(self.value) is not int or self.value < 0:
            raise ValueError("%r is not a display or file ID (%s)" % (self.value, self.name))


@dataclass(frozen=True)
class ComposedObject:
    """One object of one flavor's composed view, as objects.lua lists it."""

    name: str
    role: str


# Flavor -> object ID. A runtime alias, so it must also work on Python 3.8.
Composed = Dict[str, Dict[int, ComposedObject]]


@dataclass
class ImportResult:
    """What one import did. Everything here is for the maintainer to read."""

    added: list[tuple[int, int]] = field(default_factory=list)
    changed: list[tuple[int, int, int]] = field(default_factory=list)
    # (object ID, source's name, source's value, our name): may be another object with that ID.
    refused: list[tuple[int, str, int, str]] = field(default_factory=list)
    # (object ID, name): left the database or was renamed there, so its values were dropped.
    removed: list[tuple[int, str]] = field(default_factory=list)
    skipped: Counter = field(default_factory=Counter)


# ---------------------------------------------------------------------------------------------
# Readers
# ---------------------------------------------------------------------------------------------


def read_source(path: Path, source: str) -> dict[int, Claim]:
    """Read every object the source knows; the file's shape selects the reader."""
    if source not in SOURCES:
        raise ValueError("Unknown source %r; known: %s" % (source, " ".join(SOURCES)))
    with path.open("rb") as opened:
        is_sqlite = opened.read(16) == b"SQLite format 3\x00"
    if not is_sqlite:
        return _read_csv(path, "fileDataId" if source in FILE_ID_SOURCES else "displayId")

    connection = sqlite3.connect(path.resolve().as_uri() + "?mode=ro", uri=True)
    try:
        tables = {row[0] for row in connection.execute("SELECT name FROM sqlite_master WHERE type='table'")}
        if "gameobject_template" in tables and source in CMANGOS_REPOSITORIES:
            return _read_cmangos(connection, CMANGOS_REPOSITORIES[source])
        if "pages" in tables and source in WOWHEAD_PATHS:
            return _read_scraper_pages(connection, WOWHEAD_PATHS[source])
    finally:
        connection.close()
    raise ValueError("%s cannot be imported as %s" % (path, source))


def _read_csv(path: Path, value_column: str) -> dict[int, Claim]:
    claims = {}
    for number, row in enumerate(_csv_rows(path, {"objectId", "name", value_column}), 2):
        # An empty value means the source lists the object but not its model.
        if row[value_column] == "":
            continue
        try:
            claims[int(row["objectId"])] = Claim(int(row[value_column]), row["name"])
        except ValueError as error:
            raise ValueError("%s:%d: %s" % (path.name, number, error)) from error
    return claims


def _csv_rows(path: Path, required: set[str]) -> Iterator[dict[str, str]]:
    with path.open(encoding="utf-8-sig", newline="") as opened:
        reader = csv.DictReader(opened)
        missing = required - set(reader.fieldnames or ())
        if missing:
            raise ValueError("%s: missing columns %s" % (path, " ".join(sorted(missing))))
        for number, row in enumerate(reader, 2):
            if None in row or None in row.values():
                raise ValueError("%s:%d: wrong number of cells" % (path.name, number))
            yield row


def _read_cmangos(connection: sqlite3.Connection, repository: str) -> dict[int, Claim]:
    origin = connection.execute("SELECT value FROM artifact_metadata WHERE key = 'cmangos_db_repo'").fetchone()
    if origin is None or repository not in origin[0]:
        raise ValueError("expected a release of %s, found %s" % (repository, origin and origin[0]))
    # Players never see server-only spell focuses, traps and auras; their display is the
    # editor's placeholder, such as a pebble.
    return {entry: Claim(0 if server_only else display, name) for entry, display, name, server_only in connection.execute(
        "SELECT entry, displayId, name, type = 8 AND data3 = 1 OR type = 6 AND data8 = 1 OR type = 30 AND data6 = 1 "
        "FROM gameobject_template")}


_PAGE_DISPLAY = re.compile(r'data-mv-display-id="(\d+)" data-mv-type="2" data-mv-type-id="(\d+)"')


def _read_scraper_pages(connection: sqlite3.Connection, url_path: str) -> dict[int, Claim]:
    """Display IDs of the cached English object pages. Reads the cache only, never Wowhead."""
    # Old caches do not record where a page came from.
    columns = {row[1] for row in connection.execute("PRAGMA table_info(pages)")}
    url = "source_url" if "source_url" in columns else "NULL"
    claims = {}
    for object_id, body, source_url in connection.execute(
            "SELECT entity_id, body, %s FROM pages WHERE entity_type = 'object' AND locale = 'enUS'" % url):
        if source_url and "/%s/object=" % url_path not in source_url:
            raise ValueError("expected pages of /%s/, found %s" % (url_path, source_url))

        # A page can embed another object's viewer; only this object's counts.
        displays = [int(display) for display, viewed in _PAGE_DISPLAY.findall(body) if int(viewed) == object_id]
        data = re.search(r"g_objects\[%d\], (?=\{)" % object_id, body)
        if displays and data:
            name = json.JSONDecoder().raw_decode(body, data.end())[0].get("name", "")
            claims[object_id] = Claim(displays[0], name)
    return claims


def read_display_info(path: Path, build: str) -> Displays:
    """Reduce a GameObjectDisplayInfo CSV to one kind and one ID per display.

    Older clients have no AlternateDisplayType column: all their displays are plain models.
    Newer rows keep a FileDataID even when they show a creature or an item, so the type decides.
    """
    if not re.fullmatch(r"\d+(\.\d+){3}", build):
        raise ValueError("Build must look like 1.60.1.71091, not %r" % build)
    by_id = {}
    for row in _csv_rows(path, {"ID", "FileDataID"}):
        alternate = row.get("AlternateDisplayType", "0")
        try:
            if alternate == "0":
                file_id = int(row["FileDataID"])
                display = Display("file", file_id) if file_id else Display("none", 0)
            elif alternate == "1":
                display = Display("creature", int(row["ClientCreatureDisplayInfoID"]))
            elif alternate == "2":
                display = Display("item", int(row["ClientItemID"]))
            else:
                raise ValueError("unknown AlternateDisplayType " + alternate)
            by_id[int(row["ID"])] = display
        except (KeyError, ValueError) as error:
            raise ValueError("%s: display %s: %s" % (path.name, row["ID"], error)) from error
    if not by_id:
        raise ValueError("%s: no displays" % path)
    return Displays(build, by_id)


# ---------------------------------------------------------------------------------------------
# Merging
# ---------------------------------------------------------------------------------------------


def normalized_name(name: str) -> str:
    """Ignore case, spacing and punctuation, which differ between sources."""
    return "".join(character for character in name.casefold() if character.isalnum())


def _is_placeholder(source: str, object_id: int, claim: Claim) -> bool:
    """Values that carry no information about the object."""
    if source == "skyfire" and (claim.value in SKYFIRE_PLACEHOLDERS or normalized_name(claim.name) == SKYFIRE_NO_NAME):
        return True
    emulator = source == "skyfire" or source in CMANGOS_REPOSITORIES
    return emulator and claim.value == object_id - INVENTED_DISPLAY_OFFSET


def merge(rows: list[ObjectRow], composed: Composed, source: str,
          claims: dict[int, Claim]) -> tuple[list[ObjectRow], ImportResult]:
    """Return the rows with one source's column updated.

    Values the source no longer lists are kept: an export can be partial. A claim is taken only
    by a row with the same name, because an ID can be a different object elsewhere and
    Corrections invent IDs that other games use.
    """
    result = ImportResult()
    rows = _refresh_objects(rows, composed, result)

    users = {flavor for flavor in FLAVORS if source in SOURCE_ORDER[flavor].all}
    candidates: dict[int, list[ObjectRow]] = defaultdict(list)
    for row in rows:
        if row.flavors & users:
            candidates[row.object_id].append(row)

    for object_id, claim in sorted(claims.items()):
        if object_id not in candidates:
            result.skipped["not an object of a flavor that uses this source"] += 1
            continue
        if _is_placeholder(source, object_id, claim):
            result.skipped["placeholder"] += 1
            continue
        for row in candidates[object_id]:
            # A row without an English name in our data has nothing to compare.
            if row.name and normalized_name(row.name) != normalized_name(claim.name):
                result.refused.append((object_id, claim.name, claim.value, row.name))
                continue
            before = row.claims.get(source)
            if before is None:
                result.added.append((object_id, claim.value))
            elif before != claim.value:
                result.changed.append((object_id, before, claim.value))
            row.claims[source] = claim.value

    # Objects that no source knows need no row.
    return [row for row in rows if row.claims], result


def _refresh_objects(rows: list[ObjectRow], composed: Composed, result: ImportResult) -> list[ObjectRow]:
    """One row per composed object and name, keeping what is already known about each.

    Names are compared normalized, so flavors that only spell a name differently share a row.
    Values never move to another name: that could be another object.
    """
    groups: dict[tuple[int, str], dict[str, str]] = defaultdict(dict)
    for flavor in FLAVORS:
        for object_id, composed_object in composed[flavor].items():
            groups[object_id, normalized_name(composed_object.name)][flavor] = composed_object.name

    known = {(row.object_id, normalized_name(row.name)): row.claims for row in rows}
    result.removed = [(row.object_id, row.name) for row in rows
                      if (row.object_id, normalized_name(row.name)) not in groups]
    return [ObjectRow(object_id, next(iter(names.values())), frozenset(names), dict(known.get((object_id, name), {})))
            for (object_id, name), names in groups.items()]
