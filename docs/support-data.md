# Support data

QuestieDB owns and publishes zone mappings, quest XP, faction templates, drop tables, and
drop-table Corrections as plain Lua values through `LibQuestieDB.Support`. These datasets are
consumed as whole tables, so they do not use the TOC metadata store. The public access points
and value examples are documented in [`api.md`](./api.md#support-data).

## Flavor selection

Baked TOCs list only applicable inputs. Legacy flavors share some authored inputs; Forever
owns its flavor-specific support bundle. The committed Source TOC uses native per-file
`AllowLoadGameType` and `ExcludeLoadGameType` conditions to select applicable inputs
before Lua executes. Lua discard scopes are not a fallback. See
[client support and acceptance](forever.md#client-support-and-acceptance).

The selected data preserves the imported flavor boundaries:

- Vanilla, TBC, Wrath, and Cata use the shared area/UI map tables plus their own quest XP,
  faction-template, and drop-table variant.
- Mists uses the MoP area/UI map tables, quest XP, and faction templates.
- Forever uses nine independent files under `support/Forever`, selected by
  `[ExcludeLoadGameType vanilla, tbc, wrath, cata, mists]`. An allow list of unknown
  Forever tokens would also pass on older clients. Shared Classic rules do not make these
  inputs inherit future Era changes.
- Mists loads the MoP drop table followed by the Cata drop table. The cumulative order is
  intentional and matches Questie.

Forever's current map tables contain 1,065 forward and 54 canonical reverse DBC relationships
through build `1.60.1.70291`. The October 9 refresh also adds twelve instance identities and
26 parent links. A dungeon can have a MapID and AreaID without a UiMapID; these identity and
parent tables do not fabricate map geometry or entrances. Forty additional compatibility pairs support the consumer's lookup
before instance-entrance resolution; their retired floor UiMaps are not native Forever maps.
See [current map limitations](forever-data.md#current-support-map-limitations) and the
[compatibility audit](forever-map-override-audit.md) before refreshing exports or removing links.
Use the owned [DBC candidate exporter](../tools/dbc/README.md), then review additions before
adoption. The historical external exporter can overwrite manual additions and is not a safe
wholesale replacement.

Installing the support shim replaces the published module set and seeds shared constants.
This prevents a flavor loaded later in the emulator from retaining flavor-specific data.

Zone symbols are shared across all flavors. `src/corrections/enum/zones.lua` is their sole
source; `Support.Get("ZoneDB").zoneIDs` exposes the same table as `LibQuestieDB.Enum.zoneIDs`.
Corrections, waypoint Derived Passes, and offline coordinate conversion use those symbols too.
Edit that enum to add or correct a symbol. The Forever section includes all AreaIDs newly
present in `1.60.1.70291` compared with Era `1.15.9.70003`, with prototype/unresolved records
labeled separately. Same-name areas keep distinct qualified symbols; existing cross-flavor
values do not change. Flavor-specific map routing stays in `support/`.

## Value shapes

Owned values retain their public shapes. In particular, zone maps and item-drop
sources that Questie's wrappers pass to `loadstring` remain strings. Quest XP, faction
templates, zone IDs, dungeon records, and item-drop Corrections remain tables.

A dungeon's optional second slot is a dense `alternativeAreaIds` list, not a scalar area ID:

```lua
---@class DungeonZoneEntry
---@field [1] string name
---@field [2] AreaId[]? alternativeAreaIds
---@field [3] AreaId parentZone
---@field [4] { [1]: AreaId, [2]: number, [3]: number }[] dungeonLocations
```

Consumers should preserve these raw types when binding the values to their existing wrapper
modules.

## Maintaining inputs

[`src/config.lua`](../src/config.lua), under `config.supportData`, owns the shared and
per-flavor file selection. Update it when adding, removing, or moving a support input.
`config.sourceFileEntries()` derives native Source conditions from `config.supportFiles(flavor)`,
which also supplies Baked file lists. Regenerate the committed Source TOC after file-list changes:

```sh
lua5.1 generate.lua toc
lua5.1 test.lua support
```

The support fixtures check loading, flavor isolation, and public shapes without comparing to
an external Questie checkout. Forever's [focused dataset check](forever-data.md#focused-validation)
also checks adopted support data and faction references. Generated artifacts receive file-list and loading checks in
[flavor test scopes](../README.md#independent-test-scopes). The retired whole-table fidelity
inventory is preserved at the [migration checkpoint](adr/0014-owned-data-after-migration.md).
