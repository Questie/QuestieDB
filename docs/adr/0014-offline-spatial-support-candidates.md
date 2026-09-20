# 14. Offline spatial interpretation and support candidates

Forever needs build-specific map relationships without treating inherited dungeon lookup
keys as native maps. Interpret explicit DBC snapshots offline and export candidates in
Questie's existing deferred-Lua support format. Do not change the runtime entity schema,
TOC storage or Correction interface.

## Ownership

Owned Forever Lua remains authoritative for entity locations, Corrections and active
Support data. The spatial model is an interpretation, not a second authored entity store.
Normal Generation and runtime reads do not fetch DBC or perform coordinate conversion.

Current owned Lua override strings own suppression, native-map aliases and legacy dungeon
compatibility. The exporter reads and preserves those payloads, including their comments;
there is no second authored JSON copy of the same decisions. Generated candidates are disposable
proposals, not another place to edit policy.

Adoption into active Support data is a separate review. At adoption, only the forward/reverse
base mapping tables become generated from DBC. The override strings remain authored inputs in
the owned Lua files and are preserved on subsequent exports. Parent support remains an authored
input with bounded DBC additions proposed. The exporter never installs into active Support data.
Compare candidates against current owned Lua before adoption; do not establish a two-way sync.

Accept snapshots by explicit build with strict table coverage and reference validation. Record
actual source hashes in generated reports. Exact historical source hashes belong to acceptance
fixtures, not configuration that must be edited for every new snapshot. A structurally valid
candidate still requires content/client review before adoption.

This replaces the initial candidate-only JSON exception input: it duplicated policy already
owned by Lua, and repeated metadata did not automate its review or retirement.

## Meaning and compatibility

- An Area route selects a UiMap; it does not establish an authored point's coordinate frame.
  Preserve direct assignments. For other areas, select the highest directly mapped ancestor.
  Canonical reverse mappings come from direct assignments, never inversion of descendants.
- World MapID 0 is valid. UiMap 0 is suppression, not drawable geometry.
- Native map inventory, direct assignments, inherited routes and authored overrides remain
  separate. A retained legacy UiMap key does not establish native geometry. Classification by
  snapshot presence is not a claim about an override's coordinate basis or retirement.
- Instance presence has no point. Complete `{-1,-1}` markers stay distinct from real `{0,0}`
  points; partial sentinels fail. Phase is not a floor or event condition.
- Unsupported assignment selectors and ambiguity remain visible. Broken assignment or parent
  references fail. AreaTable references to absent world maps remain explicit diagnostics:
  the reviewed snapshot contains such unresolved areas, not enough evidence to invent maps.

The consumer must resolve instance presence before UiMap-dependent operations. Removing
compatibility pairs also requires enforceable consumer/provider version-skew safeguards.
This candidate-only tooling does neither and retains every currently reviewed pair.

## Scope

The initial implementation generates forward/reverse map candidates and their evidence
report. A bounded extension also proposes missing direct-child parent entries for the five
reviewed Forever zones. This is an explicit temporary scope in the parent exporter, not a list
of hand-maintained child relationships or a policy to include every new zone automatically.
It reads current owned parent support, preserves all existing rows and
overrides, and fails on conflicting effective parents. It does not replace that authored table
with a complete DBC projection or transfer ownership of unrelated legacy navigation data.

Neither step imports or rewrites entities, flattens conditional Lua providers, generates
entrances, replaces instance tables or introduces a world-position authoring format.
Existing coordinate tooling remains responsible for explicit projection and export rounding.
ADR 0006's raw-coordinate storage contract is unchanged.

This supersedes only DESIGN.md's original restriction to Questie-sourced data for these
Forever spatial support candidates. It does not adopt VibeQuest data, output tuples or runtime
interfaces. The existing authored data and Correction ownership rules remain in force.
