# Forever map-override usage audit

## Current disposition: local map refresh

The local refresh now adopts all 1,064 completed DBC forward relationships and 54
canonical reverse relationships, plus the handoff's seven forward and three reverse
policy overrides. It separately retains **40 compatibility pairs in both directions**:
27 ordinary dungeon areas and the 13 referenced synthetic aliases below. These retired
UiMap IDs satisfy the consumer's lookup before entrance resolution. They are **not native
Forever floor maps** and must not become an active-map allowlist.

The 27 ordinary areas are:

```text
209 491 717 718 719 721 722 796 1176 1337 1477 1581 1583 1584
1585 1977 2017 2057 2100 2159 2437 2557 2677 2717 3428 3429 3456
```

This is the union of lost mappings actually referenced by raw and corrected entity
location fields, not an inventory of numbers found by text search. Every retained area
also has an actual NPC/object spawn reference and an authored entrance route. The audit
covered spawns, waypoints, zone IDs, quest triggers, extra objectives and zone/category
fields, all provider returns/captured writes, and composed Source reads across 18 personas.
Dungeon keys and alternative IDs were resolved to their entrance triples; all retained
routes land on mapped outdoor areas. No additional legacy map link was needed for those
entrances. Reverse compatibility retains only each selected forward target, not every
historical alternate floor pointing at the same dungeon.

Current DBC rows take precedence: Grim Batol area 1037 now selects Wetlands 1437, not old
floor map 293. The 70 unused synthetic floor aliases, five unused SoD forward overrides,
and unrelated inherited main/reverse rows are not retained. Symbols, dungeon records and
instance identities remain untouched. Valley of Bones 2657 now has parent 16651 and The
Maul 3217 parent 357, matching the supplied parent facts and completed direct lookups.
The 230 other proposed parent additions remain deferred.

Validation of the local refresh:

- The registered `forever-data` Lua suite checks deferred loader shapes, current DBC
  precedence, canonical reverse links, referenced compatibility in both directions,
  positive entrance routes and missing-209/missing-10022 negative controls through the
  same spawn-derived coverage check. Missing overrides cannot skip that check.
- A temporary harness executing the inspected original consumer functions with actual
  corrected quest objectives rendered three outdoor entrance icons for quest 7461 and
  four for object-objective quest 5382. Removing 10022 still reproduced `table index is nil`.
- In a disposable provider copy, Forever validators passed 15/15 checks with zero findings.
  Golden comparison passed for 35,944 entities with zero differences; both Self-proofs passed.
- Lua syntax and the focused dataset suite passed. No live-client placement was checked.

The exporter remains unchanged. Its generation overwrites the manual completion, and a
future map import must preserve or deliberately retire the local compatibility additions.
The consumer should resolve instance markers before map indexing; these links can then be
retired after checking both NPC and object objectives. Entrance coordinate accuracy remains
a separate pending review, including the transformed outdoor maps documented in
[forever-data.md](forever-data.md).

## Historical audit before the local refresh

### Conclusion

The current Forever data uses **13 of the 83 synthetic dungeon AreaIDs** whose forward
map overrides the updated DBC handoff omits. Every use is an instance marker
`{-1,-1}`, not a position on a dungeon-floor map. Their old UiMap targets are absent
from the complete supplied Forever UiMap snapshot.

Removing those mappings nevertheless breaks the inspected pinned Questie consumer:
it indexes by UiMapID before resolving instance markers to outdoor dungeon entrances.
Do not replace the mapping files wholesale without addressing that consumer dependency.
This is offline evidence, not a live-client result.

### Inputs and scope

- Current owned files under `data/Forever`, `src/corrections/Forever` and `support/Forever`.
- Updated approved handoff:
  `/home/logon/projects/Questie-clones/Questie-db/QuestieDB-DBC/support/Zones/HANDOFF.md`
  and the adjacent forward/reverse lookup files and `reports/forever.json`.
- Complete `ui_map` snapshot for **1.60.1.69893**, read from the approved existing DBC
  cache in SQLite read-only mode, with `query_only` and explicit-build reconstruction.
- Consumer reference: project-owned Questie pin
  `454b9d072965ee8f1a881429260fcf1fac8d60f7`, not an arbitrary sibling checkout.

No implementation, data or index changes were made during that initial audit. This note records
findings separately from the historical adoption account in [forever-data.md](forever-data.md).

### What is used

The omitted forward overrides comprise 83 synthetic dungeon-floor aliases and five
SoD instance-to-outdoor mappings. The omitted reverse overrides comprise 83 floor aliases,
two continent-suppression entries and three other manual mappings.

Referenced synthetic dungeon areas:

```text
10000 10007 10011 10012 10020 10022 10023
10024 10025 10026 10027 10030 10032
```

There are **104 spawn entries across 74 NPCs and 19 objects**, all introduced by Static
Corrections and all containing `{-1,-1}`. None of the removed aliases appears as a real
coordinate, waypoint, entity `zoneID`, quest `triggerEnd`, `extraObjectives` or `zoneOrSort`
in the audited inputs/results. The other 70 dungeon aliases and all five omitted SoD
mappings have no entity-field references in this audit.

Examples in the owned providers:

- `src/corrections/Forever/classicNPCFixes.lua:1972`: Gordok Brute 11441 uses area 10022.
- The same file, lines 2065–2066: Prince Tortheldrin 11486 uses 10022 and 10025.
  Quest 7461, "The Madness Within", targets him and Immol'thar.
- `src/corrections/Forever/classicObjectFixes.lua:164–165`: Thermaplugg's Safe 142477
  uses synthetic area 10032 alongside ordinary Gnomeregan.
- The same file, lines 371–374: Incantation of Celebras 178965 uses synthetic area
  10000 alongside ordinary Maraudon.

Inherited support references are broader than active entity use: all 88 removed forward
keys have symbolic constants, 83 occur as subzone keys, 76 are dungeon alternative IDs,
and 12 are dungeon-table keys. A symbol or dungeon entry alone does not prove active content.

The six known real continent/world coordinates remain mapped: the new handoff retains
`10073 <-> 1414`, `10074 <-> 1415`, and `10089 <-> 947`.

### Client-map evidence

The complete `ui_map` snapshot has 60 records and recorded `ok` coverage. Its selected-field
projection hash matches the handoff:

```text
e265fc2189a7e46df0f0a2e9ecef23da35be96a66b556536164a834665753747
```

All 83 removed floor targets and all 88 removed reverse keys are absent. This conclusion
uses the full UiMap snapshot, not absence from the partial assignment export.

The five omitted SoD AreaIDs **do exist** in this build's AreaTable, and their outdoor target
UiMaps exist. Their exclusion is based on lack of use in current Forever entity inputs and
Forever's independent provider selection, not a claim that the DBC lacks those areas.

### Consumer dependency

The pinned [Questie objective renderer](https://github.com/Questie/Questie/blob/454b9d072965ee8f1a881429260fcf1fac8d60f7/Modules/Quest/QuestieQuest.lua#L1103)
looks up a spawn's AreaID before entrance resolution. Lines 1199–1201 use `icon.UiMapID`
as a table key; lines 1210–1237 resolve instance markers afterward.

A temporary harness executing the original functions with Prince Tortheldrin's spawn
reproduced `table index is nil` when the 10022 mapping was omitted. Retaining the current
10022-to-235 alias avoided that failure. All 13 referenced aliases still resolve through
existing dungeon records to outdoor entrances with supported UiMaps; the problem is the
ordering of map lookup and sentinel handling, not a missing entrance for these aliases.

Resolve instance markers to entrances before UiMap-dependent indexing in the consumer,
with coverage for quest 7461 and an object-based dungeon objective, before dropping these
compatibility links. Do not treat obsolete floor UiMaps as valid Forever maps merely to
satisfy that ordering dependency. Wholesale replacement also removes ordinary dungeon
mappings, so reviewing only these 13 overrides is insufficient.

### Additional routing differences

The retained subzone table conflicts with two newly completed direct lookups:

- Area 2657: new direct map 2652; old parent 405 leads to map 1443.
- Area 3217: new direct map 1444; old parent 2557 has no mapping in the new lookup.

Neither area appears in the audited entity location/category fields. Direct-first rendering
and parent-based grouping can nevertheless disagree. Review parent routing during adoption.
The current dataset test also explicitly requires reverse alias 281-to-10000; an intentional
removal requires revisiting that expectation, not merely accepting a failing test.

### Validation evidence

The audit inspected raw location fields, all six Forever providers across 180 method/persona
invocations, captured direct writes, and actual Source materialization plus Dynamic Correction
composition for both factions and nine classes. Independent token inspection recognized
140,660 coordinate pairs, including 80 NPC and 24 object removed-alias sentinels and zero
removed-alias real coordinates.

Temporary reproduction files:

- `/tmp/forever-map-usage-audit.lua`
- `/tmp/forever-map-usage-audit.log`
- `/tmp/forever-consumer-nil-map.lua`

No downloads, installing conversions, live-addon changes or client reloads ran.
