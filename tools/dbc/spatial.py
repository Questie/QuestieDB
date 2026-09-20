"""Offline area routing, separate from point frames and legacy consumer policy."""

from __future__ import annotations

from dataclasses import asdict, dataclass
import math
from typing import Optional, Union

from coordinates import Bounds


@dataclass(frozen=True)
class Area:
    """An AreaTable identity and its source parent, not a coordinate frame."""

    id: int
    name: str
    parent_id: int
    map_id: int


@dataclass(frozen=True)
class AreaRoute:
    """A selected map with the explicit assignment and ancestor that justify it."""

    area_id: int
    ui_map_id: int
    ancestor_id: int
    assignment_id: int
    parent_chain: tuple[int, ...]


@dataclass(frozen=True)
class InstancePresence:
    """Legacy instance identity with no position; entrance selection belongs to Questie."""

    area_id: int
    locator: str
    phase: Optional[int] = None


@dataclass(frozen=True)
class LegacyPoint:
    """Authored percentages whose coordinate frame is not established by area routing."""

    area_id: int
    x: float
    y: float
    locator: str
    phase: Optional[int] = None
    ui_map_id: Optional[int] = None


def legacy_position(area_id: int, x: float, y: float, locator: str,
                    phase: Optional[int] = None, *,
                    declared_ui_map: Optional[int] = None) -> Union[LegacyPoint, InstancePresence]:
    """Interpret a tuple without rounding, clamping or inferring a frame from its area.

    The locator identifies the entity/provider/field and ordered tuple in authored
    Lua. This does not evaluate providers or rebuild paths, nil holes or conditions.
    """
    if type(area_id) is not int or area_id <= 0 or not locator:
        raise ValueError("Position needs an area identity and source locator")
    if phase is not None and type(phase) is not int:
        raise ValueError("Phase must be an integer, not a floor or event condition")
    if declared_ui_map is not None and (type(declared_ui_map) is not int or declared_ui_map <= 0):
        raise ValueError("UiMap 0 is not a drawable coordinate frame")
    if not all(type(v) in (int, float) and math.isfinite(v) for v in (x, y)):
        raise ValueError("Coordinates must be finite numbers")
    if x == -1 or y == -1:
        if x != y:
            raise ValueError("Partial instance sentinel")
        if declared_ui_map is not None:
            raise ValueError("Instance presence has no coordinate frame")
        return InstancePresence(area_id, locator, phase)
    return LegacyPoint(area_id, x, y, locator, phase, declared_ui_map)


@dataclass
class SpatialLookup:
    """DBC-only routes and native map inventory, with unresolved evidence retained."""

    areas: dict[int, Area]
    ui_maps: dict[int, str]
    direct: dict[int, AreaRoute]
    resolved: dict[int, AreaRoute]
    reverse: dict[int, int]
    unresolved: list[int]
    diagnostics: list[dict]
    parent_routing_differences: list[dict]


def resolve_areas(area_rows: list[dict], map_rows: list[dict],
                  assignments: list[dict], ui_maps: dict[int, str]) -> SpatialLookup:
    """Preserve direct routes; otherwise choose the highest directly mapped ancestor.

    Callers supply scalar-validated snapshot rows with unique IDs. Broken parents,
    cycles and assignment references fail. Unsupported or ambiguous assignments
    remain diagnostic evidence, not successful geometry. AreaTable can refer to
    absent world maps; those references are reported, never fabricated.
    """
    areas = {r["ID"]: Area(r["ID"], r["AreaName_lang"], r["ParentAreaID"], r["ContinentID"])
             for r in area_rows}
    maps = {r["ID"] for r in map_rows}
    if any(i <= 0 for i in areas) or any(i <= 0 for i in ui_maps) or any(i < 0 for i in maps):
        raise ValueError("Invalid area, UiMap or world Map identity (MapID 0 is valid)")
    diagnostics = []
    chains = {}
    for area_id, area in sorted(areas.items()):
        if area.map_id not in maps:
            diagnostics.append({"kind": "area_without_world_map", "area_id": area_id,
                                "map_id": area.map_id})
        chain = []
        current = area_id
        while current:
            if current in chain:
                raise ValueError(f"AreaTable parent cycle from {area_id} through {current}")
            if current not in areas:
                raise ValueError(f"AreaTable {area_id}: missing parent {current}")
            chain.append(current)
            parent = areas[current].parent_id
            if parent in areas and areas[current].map_id != areas[parent].map_id:
                raise ValueError(f"AreaTable {current}: parent {parent} has a different world Map")
            current = parent
        chains[area_id] = tuple(chain)

    # Validate every reference, even for an assignment we cannot project.
    by_area: dict[int, list[dict]] = {}
    by_ui: dict[int, list[dict]] = {}
    eligible = []
    for row in sorted(assignments, key=lambda r: r["ID"]):
        area_id, ui_id, map_id = row["AreaID"], row["UiMapID"], row["MapID"]
        if ui_id not in ui_maps:
            raise ValueError(f"Assignment {row['ID']}: missing UiMap {ui_id}")
        if area_id != 0 and area_id not in areas:
            raise ValueError(f"Assignment {row['ID']}: missing AreaTable {area_id}")
        if map_id not in maps and not (map_id == -1 and area_id == 0):
            raise ValueError(f"Assignment {row['ID']}: missing Map {map_id}")
        if area_id and areas[area_id].map_id != map_id:
            raise ValueError(f"Assignment {row['ID']}: AreaTable world Map mismatch")
        # Include restricted primary rows in ambiguity checks. Filtering them first
        # could incorrectly promote a second assignment to unconditional truth.
        if row["OrderIndex"] == 0 and area_id:
            by_area.setdefault(area_id, []).append(row)
            by_ui.setdefault(ui_id, []).append(row)
        try:
            Bounds.from_assignment(row)
        except ValueError as error:
            diagnostics.append({"kind": "unsupported_assignment", "assignment_id": row["ID"],
                                "area_id": area_id, "ui_map_id": ui_id, "reason": str(error)})
        else:
            eligible.append(row)

    direct = {}
    reverse = {}
    for row in eligible:
        area_id, ui_id = row["AreaID"], row["UiMapID"]
        if len(by_area[area_id]) != 1 or len(by_ui[ui_id]) != 1:
            diagnostics.append({"kind": "ambiguous_assignment", "assignment_id": row["ID"],
                                "area_id": area_id, "ui_map_id": ui_id})
            continue
        direct[area_id] = AreaRoute(area_id, ui_id, area_id, row["ID"], (area_id,))
        reverse[ui_id] = area_id

    # A parent route selects a map only. It does not establish a point's basis.
    resolved = dict(direct)
    unresolved = []
    blocked = set(by_area) - set(direct)
    for area_id, chain in sorted(chains.items()):
        if area_id in direct:
            continue
        if any(i in blocked for i in chain):
            diagnostics.append({"kind": "blocked_parent_resolution", "area_id": area_id,
                                "reason": "unsupported or ambiguous explicit assignment in parent chain"})
            unresolved.append(area_id)
            continue
        ancestor = next((i for i in reversed(chain[1:]) if i in direct), None)
        if ancestor is None:
            unresolved.append(area_id)
            continue
        route = direct[ancestor]
        resolved[area_id] = AreaRoute(area_id, route.ui_map_id, ancestor, route.assignment_id,
                                      chain[:chain.index(ancestor) + 1])

    differences = []
    for area_id, route in sorted(direct.items()):
        parent_id = areas[area_id].parent_id
        if parent_id:
            parent_route = resolved.get(parent_id)
            parent_map = parent_route.ui_map_id if parent_route else None
            if route.ui_map_id != parent_map:
                differences.append({"area_id": area_id, "direct_ui_map_id": route.ui_map_id,
                                    "parent_id": parent_id, "parent_ui_map_id": parent_map})
    return SpatialLookup(areas, ui_maps, direct, resolved, reverse, unresolved, diagnostics, differences)


def route_records(lookup: SpatialLookup) -> list[dict]:
    """Return deterministic derivations for direct and inherited routes, not aliases."""
    return [asdict(route) for _, route in sorted(lookup.resolved.items())]
