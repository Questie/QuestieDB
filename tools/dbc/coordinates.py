"""Per-map percentage transforms that preserve a point's world position.

This handles unambiguous, unrestricted zone rectangles only. It does not establish
that NPCs or terrain kept the same world positions between the selected builds.
"""

from __future__ import annotations

from dataclasses import asdict, dataclass
import math


@dataclass(frozen=True)
class Bounds:
    """World bounds: horizontal follows world axis 2, vertical follows axis 1."""

    left: float
    right: float
    top: float
    bottom: float

    @property
    def width(self) -> float:
        """World units across the displayed map, positive toward decreasing world axis 2."""
        return self.left - self.right

    @property
    def height(self) -> float:
        """World units down the displayed map, positive toward decreasing world axis 1."""
        return self.top - self.bottom

    @classmethod
    def from_assignment(cls, row: dict) -> "Bounds":
        """Reject assignments whose selection or coordinate interpretation is unresolved."""
        if row["OrderIndex"] != 0:
            raise ValueError("nonprimary assignment")
        if row["AreaID"] <= 0 or row["MapID"] < 0:
            raise ValueError("no explicit zone/world identity")
        if row["WMODoodadPlacementID"] != 0 or row["WMOGroupID"] != 0:
            raise ValueError("WMO-restricted assignment")
        if tuple(row[key] for key in ("UiMin_0", "UiMin_1", "UiMax_0", "UiMax_1")) != (0, 0, 1, 1):
            raise ValueError("partial UI rectangle")
        if (row["Region_2"], row["Region_5"]) != (-1000000, 1000000):
            raise ValueError("altitude-restricted assignment")
        if row.get("uninterpreted_fields"):
            raise ValueError(f'nonzero uninterpreted fields: {row["uninterpreted_fields"]}')
        bounds = cls(row["Region_4"], row["Region_1"], row["Region_3"], row["Region_0"])
        if not all(math.isfinite(v) for v in asdict(bounds).values()):
            raise ValueError("nonfinite world bounds")
        if not (0 < bounds.width < math.inf and 0 < bounds.height < math.inf):
            raise ValueError("degenerate or reversed world bounds")
        return bounds


@dataclass(frozen=True)
class Transform:
    """Affine coefficients in Questie's 0–100 percentage units, not normalized 0–1."""

    scale_x: float
    offset_x: float
    scale_y: float
    offset_y: float

    def apply(self, x: float, y: float) -> tuple[float, float]:
        """Preserve complete instance sentinels; never clamp or round coordinates."""
        if not all(type(v) in (int, float) and math.isfinite(v) for v in (x, y)):
            raise ValueError("Coordinates must be finite numbers")
        if x == -1 or y == -1:
            if x == y == -1:
                return x, y
            raise ValueError("Partial instance sentinel; refusing to transform")
        result = (self.scale_x * x + self.offset_x, self.scale_y * y + self.offset_y)
        if not all(math.isfinite(v) for v in result):
            raise ValueError("Coordinate transform overflow")
        return result


def derive_transform(source: dict, target: dict) -> tuple[Transform, Bounds, Bounds]:
    """Require the same map/area identities before preserving their world frame."""
    for key in ("UiMapID", "AreaID", "MapID"):
        if source[key] != target[key]:
            raise ValueError(f"{key} changed: {source[key]} -> {target[key]}")
    old, new = Bounds.from_assignment(source), Bounds.from_assignment(target)
    transform = Transform(
        old.width / new.width, 100 * (new.left - old.left) / new.width,
        old.height / new.height, 100 * (new.top - old.top) / new.height,
    )
    if not all(math.isfinite(v) for v in asdict(transform).values()):
        raise ValueError("Nonfinite transform coefficients")
    return transform, old, new


def compare_maps(source: list[dict], target: list[dict],
                 source_names: dict[int, str], target_names: dict[int, str]) -> dict:
    """Report all map groups; multiple assignments are not resolved by first-wins."""
    old_maps: dict[int, list[dict]] = {}
    new_maps: dict[int, list[dict]] = {}
    for row in source:
        old_maps.setdefault(row["UiMapID"], []).append(row)
    for row in target:
        new_maps.setdefault(row["UiMapID"], []).append(row)
    # The AreaID API cannot choose between multiple primary UiMaps, even when one
    # of them has usable geometry. Use the same eligibility for offline and runtime conversion.
    area_maps = []
    for rows in (source, target):
        areas = {}
        for row in rows:
            if row["AreaID"] > 0 and row["OrderIndex"] == 0:
                areas.setdefault(row["AreaID"], set()).add(row["UiMapID"])
        area_maps.append(areas)
    report = {"transforms": [], "unsupported": [], "added_maps": [], "removed_maps": []}
    for ui_map in sorted(old_maps.keys() | new_maps.keys()):
        old_rows, new_rows = old_maps.get(ui_map, []), new_maps.get(ui_map, [])
        identity = {"ui_map_id": ui_map, "source_name": source_names.get(ui_map),
                    "target_name": target_names.get(ui_map)}
        if not old_rows or not new_rows:
            report["added_maps" if new_rows else "removed_maps"].append(identity)
            continue
        try:
            if len(old_rows) != 1 or len(new_rows) != 1:
                raise ValueError(f"multiple assignments: {len(old_rows)} source, {len(new_rows)} target")
            if identity["source_name"] is None or identity["target_name"] is None:
                raise ValueError("assignment references a missing UiMap")
            transform, old, new = derive_transform(old_rows[0], new_rows[0])
        except ValueError as error:
            report["unsupported"].append({**identity, "reason": str(error)})
            continue
        report["transforms"].append({
            **identity, "area_id": old_rows[0]["AreaID"], "map_id": old_rows[0]["MapID"],
            "source_assignment_id": old_rows[0]["ID"], "target_assignment_id": new_rows[0]["ID"],
            "changed": old != new, "coefficients": asdict(transform),
            "area_transform_supported": all(areas.get(old_rows[0]["AreaID"]) == {ui_map} for areas in area_maps),
            "source_bounds": asdict(old), "target_bounds": asdict(new),
        })
    report["summary"] = {
        "source_assignments": len(source), "target_assignments": len(target),
        "changed_maps": sum(row["changed"] for row in report["transforms"]),
        "unchanged_maps": sum(not row["changed"] for row in report["transforms"]),
        "unsupported_maps": len(report["unsupported"]),
        "added_maps": len(report["added_maps"]), "removed_maps": len(report["removed_maps"]),
    }
    return report
