"""Compare the committed object models with the composed database, offline."""
from __future__ import annotations

from collections import Counter
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

from importing import WOWHEAD_PATHS, Composed, normalized_name
from models import SOURCE_ORDER, ModelData, lua_path, render

# Most important first; see objects.lua.
ROLES = ("quest", "objective", "drop", "other")

# New content leaves gaps of a few percent. Fewer models than this means lost data.
MINIMUM_RESOLVED = 0.75


@dataclass
class FlavorReport:
    """Errors fail the check. Warnings only inform, so new content can never be blocked."""

    errors: list[str] = field(default_factory=list)
    warnings: list[str] = field(default_factory=list)
    details: dict[str, Any] = field(default_factory=dict)


def check(data: ModelData, composed: Composed, shipped: Path) -> dict[str, FlavorReport]:
    """`data` is already validated; what remains is the shipped Lua and the database."""
    return {flavor: _check_flavor(data, flavor, composed, shipped) for flavor in composed}


def _check_flavor(data: ModelData, flavor: str, composed: Composed, shipped: Path) -> FlavorReport:
    report = FlavorReport()
    objects = composed[flavor]

    # The committed Lua must be exactly what the committed sources produce. Read as text: a
    # Windows checkout may hold CRLF.
    path = lua_path(flavor, shipped)
    if not path.is_file() or path.read_text(encoding="utf-8") != render(data, flavor):
        report.errors.append("%s does not match its sources; run `questiedb object-models write`" % path.name)

    # What every object of the database shows.
    kinds: Counter = Counter()
    gaps, disagreements, renamed = [], [], []
    for object_id, composed_object in sorted(objects.items()):
        entry = {"objectId": object_id, "name": composed_object.name, "group": composed_object.role}
        model = data.resolve(flavor, object_id)
        kinds[model.kind] += 1
        if model.kind == "missing":
            gaps.append({**entry, "reason": model.reason, "wowhead": _wowhead_page(flavor, object_id)})
        files = data.disagreement(flavor, object_id)
        if files:
            disagreements.append({**entry, "files": files})
        row = data.row(flavor, object_id)
        if row and normalized_name(row.name) != normalized_name(composed_object.name):
            renamed.append({**entry, "knownAs": row.name})

    if len(gaps) > (1 - MINIMUM_RESOLVED) * len(objects):
        report.errors.append("%d of %d objects have no known model; is sources.tsv complete?" % (len(gaps), len(objects)))

    # Quest and objective gaps are what a player would notice first.
    for gap in gaps:
        if gap["group"] in ("quest", "objective"):
            report.warnings.append("%s object %d %s has no model: %s"
                                   % (gap["group"], gap["objectId"], gap["name"], gap["reason"]))
    for entry in renamed:
        report.warnings.append("object %d is now %s, but its model was found as %s; import a source or settle it "
                               "in manual.tsv" % (entry["objectId"], entry["name"], entry["knownAs"]))
    report.details = {
        "build": data.displays[flavor].build,
        "objects": len(objects),
        "kinds": dict(sorted(kinds.items())),
        "missingByGroup": {role: sum(gap["group"] == role for gap in gaps) for role in ROLES},
        "gaps": gaps,
        "renamed": renamed,
        "disagreements": disagreements,
        # Known objects that left the database. Harmless: the next import drops them.
        "gone": [object_id for object_id in data.object_ids(flavor) if object_id not in objects],
    }
    return report


def _wowhead_page(flavor: str, object_id: int) -> str:
    """For the maintainer to open by hand; the tools never request it."""
    path = next(WOWHEAD_PATHS[source] for source in SOURCE_ORDER[flavor].own if source in WOWHEAD_PATHS)
    return "https://www.wowhead.com/%s/object=%d" % (path, object_id)
