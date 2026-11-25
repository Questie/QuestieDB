"""Committed object-model data: which model each game object has on each flavor.

`data/sources.tsv` holds what every source says, one row per object and name. `data/manual.tsv`
holds reviewed decisions and always wins. `data/displays/` is the client's GameObjectDisplayInfo,
reduced to one kind and one ID per display. The correction providers in src/corrections that fill
Object.modelFileId are generated from all of them.
"""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
import re
from typing import Iterable, Optional

ROOT = Path(__file__).resolve().parents[2]
# Inputs stay with the tool; only the generated providers belong to the addon.
DATA = Path(__file__).resolve().parent / "data"
CORRECTIONS = ROOT / "src/corrections"

# One letter per flavor keeps the flavors column of sources.tsv readable.
FLAVOR_LETTERS = {
    "Vanilla": "V", "SoD": "S", "TBC": "T", "Wrath": "W", "Cata": "C", "Mists": "M", "Forever": "F",
}
# SoD is the objects that only Season of Discovery adds to Vanilla. They need a Dynamic provider of
# their own, so the tool treats them as a flavor. The client is Vanilla's.
FLAVORS = tuple(FLAVOR_LETTERS)
DISPLAYS_FROM = {flavor: flavor for flavor in FLAVORS}
DISPLAYS_FROM["SoD"] = "Vanilla"


@dataclass(frozen=True)
class Provider:
    """The generated correction file of one flavor; src/corrections/manifest.lua registers it."""

    path: str
    module: str


PROVIDERS = {
    "Vanilla": Provider("ObjectModels/classicObjectModels.lua", "ClassicObjectModels"),
    "SoD": Provider("Sod/sodObjectModels.lua", "SeasonOfDiscovery"),
    "TBC": Provider("ObjectModels/tbcObjectModels.lua", "TbcObjectModels"),
    "Wrath": Provider("ObjectModels/wotlkObjectModels.lua", "WotlkObjectModels"),
    "Cata": Provider("ObjectModels/cataObjectModels.lua", "CataObjectModels"),
    "Mists": Provider("ObjectModels/mopObjectModels.lua", "MopObjectModels"),
    "Forever": Provider("ObjectModels/foreverObjectModels.lua", "ForeverObjectModels"),
}

# First part of every client build of a flavor, so one flavor's displays cannot replace another's.
FLAVOR_BUILDS = {
    "Vanilla": "1.15.", "SoD": "1.15.", "TBC": "2.", "Wrath": "3.", "Cata": "4.", "Mists": "5.", "Forever": "1.60.",
}

# AllTheThings records a model FileDataID. Every other source records a display ID.
FILE_ID_SOURCES = frozenset({"att"})


@dataclass(frozen=True)
class SourceOrder:
    """First usable value wins: own sources, then fallbacks, then AllTheThings.

    Own sources describe this flavor. Fallbacks describe another expansion and may differ for
    good reasons; they only fill gaps.
    """

    own: tuple[str, ...]
    fallback: tuple[str, ...] = ()

    @property
    def all(self) -> tuple[str, ...]:
        return (*self.own, *self.fallback, "att")


SOURCE_ORDER = {
    "Vanilla": SourceOrder(("wowhead-classic", "cmangos-classic"), ("cmangos-tbc", "cmangos-wotlk")),
    "TBC": SourceOrder(("wowhead-tbc", "cmangos-tbc"), ("cmangos-classic", "cmangos-wotlk")),
    "Wrath": SourceOrder(("wowhead-wotlk", "cmangos-wotlk"), ("cmangos-tbc", "cmangos-classic")),
    "Cata": SourceOrder(("wowhead-cata",), ("skyfire", "cmangos-wotlk", "cmangos-tbc", "cmangos-classic")),
    "Mists": SourceOrder(("wowhead-mop", "skyfire"), ("cmangos-wotlk", "cmangos-tbc", "cmangos-classic")),
    "Forever": SourceOrder(("wowhead-forever",), ("cmangos-classic",)),
}
SOURCE_ORDER["SoD"] = SOURCE_ORDER["Vanilla"]
# Every source that some flavor uses; also the column order of sources.tsv.
SOURCES = tuple(sorted({source for order in SOURCE_ORDER.values() for source in order.all}))


@dataclass
class ObjectRow:
    """One object and what each source says about it.

    Flavors that name an ID differently get a row each, so a value cannot leak between two
    objects that share an ID: 410020 is SoD's Owl Statue, and an invented cage from TBC on.
    """

    object_id: int
    name: str
    flavors: frozenset[str]
    # Source name -> display ID (a FileDataID for FILE_ID_SOURCES). 0: the source says the
    # object has no display. A source that does not know the object is absent.
    claims: dict[str, int]


@dataclass(frozen=True)
class ManualRow:
    """A reviewed decision. Display 0 means the object has no model on purpose."""

    object_id: int
    flavors: frozenset[str]
    display_id: int
    note: str


DISPLAY_KINDS = ("file", "creature", "item", "none")


@dataclass(frozen=True)
class Display:
    """What one display ID shows: a model file, a creature display, an item, or nothing."""

    kind: str
    id: int

    def __post_init__(self) -> None:
        if self.kind not in DISPLAY_KINDS or self.id < 0 or (self.kind == "none") != (self.id == 0):
            raise ValueError("invalid display %s %d" % (self.kind, self.id))


@dataclass
class Displays:
    """One client build's displays."""

    build: str
    by_id: dict[int, Display]

    def __post_init__(self) -> None:
        self.file_ids = frozenset(display.id for display in self.by_id.values() if display.kind == "file")
        # Displays are numbered upwards, so a higher ID belongs to a newer client.
        self.highest = max(self.by_id, default=0)


@dataclass(frozen=True)
class Model:
    """Resolved answer for one object on one flavor.

    Only kind `file` ships. `creature`, `item` and `hidden` are real displays without a plain
    visible model. `none` means there is no model: reviewed, or every source that knows the
    object says so. `missing` means we do not know; `reason` says why.
    """

    kind: str
    id: int = 0
    source: str = ""
    reason: str = ""


@dataclass
class ModelData:
    """Every committed input. Building it validates the inputs against each other."""

    rows: list[ObjectRow]
    manual: list[ManualRow]
    hidden: dict[int, str]
    displays: dict[str, Displays]

    def __post_init__(self) -> None:
        self._rows: dict[tuple[str, int], ObjectRow] = {}
        for row in self.rows:
            for flavor in row.flavors:
                if (flavor, row.object_id) in self._rows:
                    raise ValueError("sources.tsv: object %d has two rows for %s" % (row.object_id, flavor))
                self._rows[flavor, row.object_id] = row

        self._manual: dict[tuple[str, int], ManualRow] = {}
        for manual in self.manual:
            for flavor in sorted(manual.flavors):
                if (flavor, manual.object_id) in self._manual:
                    raise ValueError("manual.tsv: object %d has two rows for %s" % (manual.object_id, flavor))
                displays = self.displays[flavor]
                display = displays.by_id.get(manual.display_id)
                if manual.display_id and (display is None or display.kind == "none"):
                    raise ValueError("manual.tsv: object %d: display %d shows nothing in %s %s"
                                     % (manual.object_id, manual.display_id, flavor, displays.build))
                self._manual[flavor, manual.object_id] = manual

        for flavor, displays in self.displays.items():
            if not displays.build.startswith(FLAVOR_BUILDS[flavor]):
                raise ValueError("displays: build %s is not a %s client" % (displays.build, flavor))

        # A mistyped file would silently hide nothing.
        for file_id in self.hidden:
            if not any(file_id in displays.file_ids for displays in self.displays.values()):
                raise ValueError("hidden.tsv: no client has model file %d" % file_id)

    def row(self, flavor: str, object_id: int) -> Optional[ObjectRow]:
        return self._rows.get((flavor, object_id))

    def manual_row(self, flavor: str, object_id: int) -> Optional[ManualRow]:
        return self._manual.get((flavor, object_id))

    def object_ids(self, flavor: str) -> list[int]:
        """Objects of one flavor that any source or reviewed row knows, ascending."""
        known = {object_id for listed, object_id in self._rows if listed == flavor}
        return sorted(known | {object_id for listed, object_id in self._manual if listed == flavor})

    def resolve(self, flavor: str, object_id: int) -> Model:
        """Pick the model of one object on one flavor; a manual row beats every source."""
        displays = self.displays[flavor]
        manual = self.manual_row(flavor, object_id)
        if manual is not None:
            if manual.display_id == 0:
                return Model("none", source="manual")
            return self._shown(displays.by_id[manual.display_id], "manual")

        # First source whose value this flavor's client can show.
        row = self.row(flavor, object_id)
        no_display_source = unusable = ""
        for source in SOURCE_ORDER[flavor].all:
            value = row.claims.get(source) if row else None
            if value is None:
                continue
            if value == 0:
                no_display_source = no_display_source or source
                continue
            display = self._usable(displays, source, value)
            if display is not None:
                return self._shown(display, source)
            # This flavor's own source is ahead of our table. Another expansion's model is
            # probably the wrong one, so say what to do instead of guessing.
            if source in SOURCE_ORDER[flavor].own and value > displays.highest:
                return Model("missing", reason="display %d is newer than %s; update the displays"
                                               % (value, displays.build))
            unusable = unusable or "%s %d is not in %s" % (
                "file" if source in FILE_ID_SOURCES else "display", value, displays.build)
        if unusable:
            return Model("missing", reason=unusable)
        if no_display_source:
            return Model("none", source=no_display_source)
        return Model("missing", reason="no source")

    def disagreement(self, flavor: str, object_id: int) -> dict[str, int]:
        """Files claimed by the chosen source, this flavor's own sources and AllTheThings, if they differ.

        Empty when they agree, or when a manual row already settles it.
        """
        row = self.row(flavor, object_id)
        if row is None or self.manual_row(flavor, object_id) is not None:
            return {}
        files = {}
        for source in (self.resolve(flavor, object_id).source, *SOURCE_ORDER[flavor].own, "att"):
            display = self._usable(self.displays[flavor], source, row.claims.get(source, 0))
            if display is not None and display.kind == "file":
                files[source] = display.id
        return files if len(set(files.values())) > 1 else {}

    @staticmethod
    def _usable(displays: Displays, source: str, value: int) -> Optional[Display]:
        if source in FILE_ID_SOURCES:
            # No display to look up, so require that this client ships the file.
            return Display("file", value) if value in displays.file_ids else None
        display = displays.by_id.get(value)
        return None if display is None or display.kind == "none" else display

    def _shown(self, display: Display, source: str) -> Model:
        if display.kind == "file" and display.id in self.hidden:
            return Model("hidden", display.id, source)
        return Model(display.kind, display.id, source)


# ---------------------------------------------------------------------------------------------
# Files
# ---------------------------------------------------------------------------------------------


def load(data: Path = DATA) -> ModelData:
    """Read and validate every committed input; malformed files raise ValueError."""
    return ModelData(
        rows=read_sources(data / "sources.tsv"),
        manual=read_manual(data / "manual.tsv"),
        hidden=read_hidden(data / "hidden.tsv"),
        displays=load_displays(data),
    )


def load_displays(data: Path) -> dict[str, Displays]:
    """Display tables by flavor; flavors of one client share theirs."""
    tables = {flavor: read_displays(data / "displays" / (flavor + ".tsv")) for flavor in set(DISPLAYS_FROM.values())}
    return {flavor: tables[DISPLAYS_FROM[flavor]] for flavor in FLAVORS}


def _read_tsv(path: Path, header: tuple[str, ...]) -> Iterable[tuple[str, list[str]]]:
    """Yield (location, cells). Leading `#` lines are comments; rows must be sorted by ID."""
    seen_header = False
    previous = -1
    with path.open(encoding="utf-8") as lines:
        for number, line in enumerate(lines, 1):
            line = line.rstrip("\n")
            if line.startswith("#") and not seen_header:
                continue
            cells = line.split("\t")
            where = "%s:%d" % (path.name, number)
            if not seen_header:
                if tuple(cells) != header:
                    raise ValueError("%s: expected columns %s" % (where, " ".join(header)))
                seen_header = True
                continue
            if len(cells) != len(header):
                raise ValueError("%s: expected %d columns, found %d" % (where, len(header), len(cells)))
            if not re.fullmatch(r"[1-9][0-9]*", cells[0]):
                raise ValueError("%s: invalid ID %r" % (where, cells[0]))
            if int(cells[0]) < previous:
                raise ValueError("%s: ID %s is out of order" % (where, cells[0]))
            previous = int(cells[0])
            yield where, cells
    if not seen_header:
        raise ValueError("%s: missing header" % path.name)


def _integer(where: str, value: str) -> int:
    if not re.fullmatch(r"0|[1-9][0-9]*", value):
        raise ValueError("%s: expected a number, found %r" % (where, value))
    return int(value)


_SOURCES_HEADER = ("objectId", "flavors", "name")


def read_sources(path: Path) -> list[ObjectRow]:
    """A source without any value has no column."""
    with path.open(encoding="utf-8") as opened:
        header = next((line.rstrip("\n").split("\t") for line in opened if not line.startswith("#")), [])
    columns = header[len(_SOURCES_HEADER):]
    unknown = [column for column in columns if column not in SOURCES]
    if unknown or len(set(columns)) != len(columns):
        raise ValueError("sources.tsv: unknown or repeated source columns: " + " ".join(unknown or columns))

    letters = {letter: flavor for flavor, letter in FLAVOR_LETTERS.items()}
    rows = []
    for where, cells in _read_tsv(path, (*_SOURCES_HEADER, *columns)):
        if not cells[1] or any(letter not in letters for letter in cells[1]):
            raise ValueError("%s: unknown flavors %r" % (where, cells[1]))
        claims = {source: _integer(where, cell) for source, cell in zip(columns, cells[3:]) if cell}
        rows.append(ObjectRow(int(cells[0]), cells[2], frozenset(letters[c] for c in cells[1]), claims))
    return rows


def render_sources(rows: list[ObjectRow]) -> str:
    """Only importers write this file; reviewed decisions belong in manual.tsv."""
    columns = [source for source in SOURCES if any(source in row.claims for row in rows)]
    lines = [
        "# Written by `questiedb object-models import`. Do not edit; put reviewed values in manual.tsv.",
        "# flavors: " + " ".join("%s=%s" % (letter, flavor) for flavor, letter in FLAVOR_LETTERS.items()),
        "# Cells are display IDs, except att: model FileDataIDs. 0: no display. Empty: not known.",
        "\t".join((*_SOURCES_HEADER, *columns)),
    ]
    for row in sorted(rows, key=lambda row: (row.object_id, row.name)):
        flavors = "".join(letter for flavor, letter in FLAVOR_LETTERS.items() if flavor in row.flavors)
        cells = [str(row.claims[source]) if source in row.claims else "" for source in columns]
        lines.append("\t".join([str(row.object_id), flavors, row.name, *cells]))
    return "\n".join(lines) + "\n"


def read_manual(path: Path) -> list[ManualRow]:
    rows = []
    for where, (object_id, flavors, display_id, note) in _read_tsv(
            path, ("objectId", "flavors", "displayId", "note")):
        names = FLAVORS if flavors == "all" else tuple(flavors.split(","))
        unknown = [name for name in names if name not in FLAVORS]
        if unknown:
            raise ValueError("%s: unknown flavor %r" % (where, unknown[0]))
        if not note.strip():
            raise ValueError("%s: a reviewed row needs a note saying why" % where)
        rows.append(ManualRow(int(object_id), frozenset(names), _integer(where, display_id), note))
    return rows


def read_hidden(path: Path) -> dict[int, str]:
    hidden = {}
    for where, (file_id, note) in _read_tsv(path, ("fileDataId", "note")):
        if not note.strip():
            raise ValueError("%s: a hidden model needs a note saying why" % where)
        hidden[int(file_id)] = note
    return hidden


def read_displays(path: Path) -> Displays:
    with path.open(encoding="utf-8") as lines:
        build = re.fullmatch(r"# GameObjectDisplayInfo (\d+(?:\.\d+){3})\n", lines.readline())
    if build is None:
        raise ValueError("%s: the first line must name the GameObjectDisplayInfo build" % path.name)
    by_id: dict[int, Display] = {}
    for where, (display_id, kind, value) in _read_tsv(path, ("displayId", "kind", "id")):
        if int(display_id) in by_id:
            raise ValueError("%s: display %s is listed twice" % (where, display_id))
        try:
            by_id[int(display_id)] = Display(kind, _integer(where, value))
        except ValueError as error:
            raise ValueError("%s: %s" % (where, error)) from error
    return Displays(build.group(1), by_id)


def render_displays(displays: Displays) -> str:
    lines = ["# GameObjectDisplayInfo " + displays.build, "displayId\tkind\tid"]
    lines += ["%d\t%s\t%d" % (i, d.kind, d.id) for i, d in sorted(displays.by_id.items())]
    return "\n".join(lines) + "\n"


# ---------------------------------------------------------------------------------------------
# Generated providers
# ---------------------------------------------------------------------------------------------

_STATIC = """\
-- GENERATED by `questiedb object-models write`. Do not edit; see tools/object-models/README.md.
-- Model FileDataIDs for %(flavor)s objects, from GameObjectDisplayInfo %(build)s.
---@class %(module)s
local %(module)s = QuestieLoader:CreateModule("%(module)s")
---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")

function %(module)s:Load()
    local modelFileId = QuestieDB.objectKeys.modelFileId
    local modelFileIds = {
%(models)s
    }
    local rows = {}
    for objectId, fileId in pairs(modelFileIds) do
        rows[objectId] = {[modelFileId] = fileId}
    end
    return rows
end
"""

# A Dynamic row creates its object, so this one follows the providers that add SoD's objects.
_SOD = """\
-- GENERATED by `questiedb object-models write`. Do not edit; see tools/object-models/README.md.
-- Model FileDataIDs for the objects Season of Discovery adds, from GameObjectDisplayInfo %(build)s.
---@type %(module)s
local %(module)s = QuestieLoader:ImportModule("%(module)s")
---@type QuestieDB
local QuestieDB = QuestieLoader:ImportModule("QuestieDB")

function %(module)s:LoadObjectModels()
    local modelFileId = QuestieDB.objectKeys.modelFileId
    local modelFileIds = {
%(models)s
    }
    -- A row would bring back an object that the other providers no longer add.
    local baseObjects, objects = %(module)s:LoadBaseObjects(), %(module)s:LoadObjects()
    local rows = {}
    for objectId, fileId in pairs(modelFileIds) do
        if baseObjects[objectId] or objects[objectId] then
            rows[objectId] = {[modelFileId] = fileId}
        end
    end
    return rows
end
"""


def render(data: ModelData, flavor: str) -> str:
    """Generated provider of one flavor, one object per line.

    Depends only on committed files, never on the composed database, so editing entity data
    cannot make it stale. The provider skips objects that the database does not have.
    """
    models = ((object_id, data.resolve(flavor, object_id)) for object_id in data.object_ids(flavor))
    return (_SOD if flavor == "SoD" else _STATIC) % {
        "flavor": flavor, "build": data.displays[flavor].build, "module": PROVIDERS[flavor].module,
        "models": "\n".join("[%d] = %d," % (object_id, model.id) for object_id, model in models
                            if model.kind == "file"),
    }


def provider_path(flavor: str, corrections: Path = CORRECTIONS) -> Path:
    return corrections / PROVIDERS[flavor].path


def write_files(data: ModelData, changed: dict[Path, str], corrections: Path = CORRECTIONS) -> list[Path]:
    """Write the changed inputs and the providers generated from them.

    `data` is already validated and everything is rendered first, so bad input cannot leave
    half-written files. LF on every platform keeps contributors' files identical.
    """
    outputs = {**changed, **{provider_path(flavor, corrections): render(data, flavor) for flavor in FLAVORS}}
    for path, text in outputs.items():
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(text.encode("utf-8"))
    return list(outputs)
