"""Propose world Map-to-area identities independently of UiMap geometry."""
from __future__ import annotations

from spatial import SpatialLookup
from support_lua import append_support_rows, read_instance_table

INSTANCE_TYPES = {1, 2, 3, 4}


def extend_instances(source: bytes, zone_ids: dict[str, int], lookup: SpatialLookup,
                     map_rows: list[dict]) -> tuple[bytes, dict[int, int], dict]:
    """Preserve authored identities; add explicit links or unique instance-map roots.

    All snapshot maps receive evidence and a disposition, including test/unused
    identities. This inventory is not an active-content allowlist. A conflicting
    authored link blocks the candidate rather than being silently replaced.
    """
    text = source.decode("utf-8")
    authored = read_instance_table(text, zone_ids)
    if any(area <= 0 for area in authored.values.values()):
        raise ValueError("Instance support needs positive AreaIDs")
    roots_by_map: dict[int, list[int]] = {}
    for area_id, area in sorted(lookup.areas.items()):
        if area.parent_id == 0:
            roots_by_map.setdefault(area.map_id, []).append(area_id)

    resolved = {}
    records = []
    additions = []
    for row in sorted(map_rows, key=lambda row: row["ID"]):
        map_id, explicit, instance_type = row["ID"], row["AreaTableID"], row["InstanceType"]
        if explicit < 0 or instance_type < 0:
            raise ValueError(f"Map {map_id}: invalid AreaTableID or InstanceType")
        roots = roots_by_map.get(map_id, [])
        target = None
        # Explicit source links take priority, even when the target belongs to an
        # outdoor world map. Do not impose same-map geometry on identity links.
        if explicit:
            method = "explicit_area_table_id"
            if explicit in lookup.areas:
                target = explicit
                reason = None
            else:
                reason = "explicit_area_absent_from_snapshot"
        elif instance_type in INSTANCE_TYPES:
            method = "unique_instance_root"
            if len(roots) == 1:
                target = roots[0]
                reason = None
            else:
                reason = "multiple_instance_roots" if roots else "no_instance_root"
        else:
            method = None
            reason = "outside_instance_fallback_scope"

        existing = authored.values.get(map_id)
        if target is not None and existing is not None and target != existing:
            raise ValueError(f"Map {map_id}: authored instance area {existing} conflicts with DBC area "
                             f"{target} ({method}; AreaTableID={explicit}, roots={roots})")
        if target is not None:
            disposition = "existing" if existing is not None else "addition"
            resolved[map_id] = target
            if existing is None:
                additions.append({"key": map_id, "value": target})
        elif existing is not None:
            disposition = "authored_resolution"
            resolved[map_id] = existing
        else:
            disposition = "unresolved" if method else "excluded"
        records.append({"map_id": map_id, "name": row["MapName_lang"],
                        "instance_type": instance_type, "explicit_area_id": explicit,
                        "root_area_ids": roots, "method": method, "reason": reason,
                        "derived_area_id": target, "authored_area_id": existing,
                        "area_id": resolved.get(map_id), "disposition": disposition})

    snapshot_maps = {row["ID"] for row in map_rows}
    legacy = [{"map_id": key, "area_id": value, "disposition": "preserved_absent_map"}
              for key, value in sorted(authored.values.items()) if key not in snapshot_maps]
    output = append_support_rows(text, authored, additions,
                                 "DBC world Map identities; not an active-instance allowlist. See candidate report.json.")
    report = {"relationships": records, "preserved_absent_maps": legacy,
              "added": len(additions), "preserved_authored_rows": len(authored.values),
              "resolved_snapshot_maps": len(resolved),
              "unresolved": sum(row["disposition"] == "unresolved" for row in records),
              "fallback_instance_types": sorted(INSTANCE_TYPES)}
    return output, resolved, report
