# 14. Offline spatial interpretation and support candidates

Forever needs build-specific map relationships without treating inherited dungeon lookup
keys as native maps. Interpret explicit DBC snapshots offline and export candidates in
Questie's existing deferred-Lua support format. Do not change the runtime entity schema,
TOC storage or Correction interface.

## Ownership

Owned Forever Lua remains authoritative for entity locations, Corrections and active
Support data. The spatial model is an interpretation, not a second authored entity store.
Normal Generation and runtime reads do not fetch DBC or perform coordinate conversion.

The candidate exporter's reviewed exception input owns its suppression, native-alias and
retired-map compatibility decisions. Generated candidates are disposable outputs; make
candidate policy changes in that input, not in generated Lua. The initial input records
existing reviewed policy, including the 40 retained dungeon pairs. It is pinned to the exact
Forever build and reviewed source projections.

Adoption into active Support data is a separate review. At adoption, declare these two
mapping fields generated and transfer their edits to source facts or reviewed exceptions.
Until then, the exporter does not install into active Support data or claim authority over
later authored changes. Compare candidates against current owned Lua before any adoption.
Do not establish an indefinite two-way synchronization workflow.

## Meaning and compatibility

- An Area route selects a UiMap; it does not establish an authored point's coordinate frame.
  Preserve direct assignments. For other areas, select the highest directly mapped ancestor.
  Canonical reverse mappings come from direct assignments, never inversion of descendants.
- World MapID 0 is valid. UiMap 0 is suppression, not drawable geometry.
- Native map inventory, direct assignments, inherited routes and compatibility exceptions
  remain separate. A retained retired UiMap key does not establish native geometry.
- Instance presence has no point. Complete `{-1,-1}` markers stay distinct from real `{0,0}`
  points; partial sentinels fail. Phase is not a floor or event condition.
- Unsupported assignment selectors and ambiguity remain visible. Broken assignment or parent
  references fail. AreaTable references to absent world maps remain explicit diagnostics:
  the reviewed snapshot contains such unresolved areas, not enough evidence to invent maps.

The consumer must resolve instance presence before UiMap-dependent operations. Removing
compatibility pairs also requires enforceable consumer/provider version-skew safeguards.
This candidate-only tooling does neither and retains every currently reviewed pair.

## Scope

The first implementation generates only forward/reverse map candidates and their evidence
report. It does not import or rewrite entities, flatten conditional Lua providers, generate
entrances, replace subzone/instance tables or introduce a world-position authoring format.
Existing coordinate tooling remains responsible for explicit projection and export rounding.
ADR 0006's raw-coordinate storage contract is unchanged.

This supersedes only DESIGN.md's original restriction to Questie-sourced data for these
Forever spatial support candidates. It does not adopt VibeQuest data, output tuples or runtime
interfaces. The existing authored data and Correction ownership rules remain in force.
