"""Propose bounded DBC parent additions without replacing authored navigation data."""
from __future__ import annotations

from spatial import SpatialLookup
from support_lua import append_support_rows, read_support_tables

# Temporary migration scope, not the full set of valid Forever parent relationships.
# Widen it only through a parent-routing review, not merely a new snapshot's availability.
REVIEWED_PARENT_SCOPE = {
    "id": "forever-reviewed-zone-parents",
    "parent_area_ids": [616, 16591, 16593, 16606, 16651],
    "reason": "Propose direct children of the five reviewed zones; preserve other authored navigation.",
    "evidence": "Questie commit 8f590aa47, zoneData.lua; docs/forever-spatial-validation.md",
}


def extend_parents(source: bytes, lookup: SpatialLookup, scope: dict, *,
                   instance_maps: frozenset[int] = frozenset(),
                   unresolved_instance_maps: frozenset[int] = frozenset()) -> tuple[bytes, dict]:
    """Add reviewed zone children and resolved instance-map edges; preserve authored bytes.

    Existing effective relationships must agree, or the whole candidate fails.
    Source mode supports only the two literal deferred parent tables, not executable
    providers. The caller supplies a coverage-validated, explicit-build snapshot.
    """
    required = {"id", "parent_area_ids", "reason", "evidence"}
    if not isinstance(scope, dict) or set(scope) != required:
        raise ValueError("A reviewed parent scope is required")
    if any(not isinstance(scope[k], str) or not scope[k].strip() for k in ("id", "reason", "evidence")):
        raise ValueError("Parent scope needs identity, reason and evidence")
    roots = scope["parent_area_ids"]
    if not isinstance(roots, list) or not roots or any(type(i) is not int for i in roots):
        raise ValueError("Parent scope must list explicit AreaIDs")
    if len(set(roots)) != len(roots) or any(i not in lookup.direct for i in roots):
        raise ValueError("Parent scope needs unique directly mapped real areas")

    text = source.decode("utf-8")
    base, overrides = read_support_tables(text, "subZoneToParentZone")
    if any(key <= 0 or value < -1 for table in (base, overrides) for key, value in table.values.items()):
        raise ValueError("Invalid parent support entry")
    effective = {**base.values, **overrides.values}
    selected = []
    additions = []
    unresolved = []
    for area_id, area in sorted(lookup.areas.items()):
        reviewed_child = area.parent_id in roots
        # SpatialLookup has already validated same-map parent references and cycles.
        # Select every depth within a resolved instance map, without requiring a UiMap.
        instance_child = area.parent_id != 0 and area.map_id in instance_maps
        if area.parent_id and area.map_id in unresolved_instance_maps:
            unresolved.append({"area_id": area_id, "parent_id": area.parent_id,
                               "map_id": area.map_id, "reason": "unresolved_instance_identity"})
        if not reviewed_child and not instance_child:
            continue
        if reviewed_child:
            route = lookup.resolved.get(area_id)
            if route is None or route.ui_map_id != lookup.direct[area.parent_id].ui_map_id:
                raise ValueError(f"Area {area_id}: reviewed parent and selected map disagree")
        if area_id in effective and effective[area_id] != area.parent_id:
            raise ValueError(f"Area {area_id}: authored parent {effective[area_id]} conflicts with DBC {area.parent_id}")
        record = {"area_id": area_id, "parent_id": area.parent_id,
                  "disposition": "existing" if area_id in effective else "addition"}
        if instance_child:
            record.update({"map_id": area.map_id, "scope": "resolved_instance_map"})
        selected.append(record)
        if area_id not in effective:
            additions.append(record)

    # Keep all overrides, comments and unrelated legacy rows exactly as authored.
    # These are additions, not a broad regeneration from the incomplete DBC view.
    comment = ("DBC reviewed zone children and resolved instance-map parents; see candidate report.json."
               if instance_maps else "DBC direct children of reviewed Forever zones; see candidate report.json.")
    output = append_support_rows(text, base,
                                 [{"key": row["area_id"], "value": row["parent_id"]} for row in additions], comment)
    report = {"scope": scope, "instance_map_ids": sorted(instance_maps),
              "relationships": selected, "unresolved": unresolved,
              "added": len(additions), "already_present": len(selected) - len(additions),
              "preserved_base_rows": len(base.values), "preserved_override_rows": len(overrides.values)}
    return output, report
