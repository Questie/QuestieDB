# Support data

QuestieDB owns and publishes zone mappings, quest XP, faction templates, drop tables, and
drop-table Corrections as plain Lua values through `LibQuestieDB.Support`. These datasets are
consumed as whole tables, so they do not use the TOC metadata store. The public access points
and value examples are documented in [`api.md`](./api.md#support-data).

## Flavor selection

Baked TOCs list the shared inputs and only the variant inputs for their flavor. The committed
Source TOC must work on every supported client, so it lists each variant once. Scope markers
admit assignments for the active flavor and direct all other assignments to temporary,
unpublished modules. Rejected values never appear through `Support.Get` or `Support.GetAll`.

The selected data preserves the imported flavor boundaries:

- Vanilla, TBC, Wrath, and Cata use the shared area/UI map tables plus their own quest XP,
  faction-template, and drop-table variant.
- Mists uses the MoP area/UI map tables, quest XP, and faction templates.
- Mists loads the MoP drop table followed by the Cata drop table. The cumulative order is
  intentional and matches Questie.

Installing the support shim starts with an empty published module set. This prevents a flavor
loaded later in the emulator from retaining modules or values selected for an earlier flavor.

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
Source-mode grouping in `config.supportSourceGroups` must produce the same effective selection
as `config.supportData.perFlavor`. Regenerate the committed Source TOC after file-list changes:

```sh
lua5.1 generate.lua toc
lua5.1 test.lua support
```

The support fixtures check loading, flavor isolation, and public shapes without comparing to
an external Questie checkout. Generated artifacts also receive file-list and loading checks in
[flavor test scopes](../README.md#independent-test-scopes). The retired whole-table fidelity
inventory is preserved at the [migration checkpoint](adr/0014-owned-data-after-migration.md).
