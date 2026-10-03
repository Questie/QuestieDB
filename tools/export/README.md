# Inline Forever export

From the repository root, one command exports all four databases using the bundled Lua runtime.

Linux/WSL x64:

```sh
./tools/lua-binary/linux-x64/lua tools/export-forever.lua
```

Windows PowerShell:

```powershell
.\tools\lua-binary\lua.exe tools/export-forever.lua
```

To include authored Forever Static Corrections, add `--include-authored`.
An installed Lua 5.1-compatible interpreter can replace the bundled executable if preferred.

The command writes these gitignored files under `src/corrections/Forever/combined/`:

- `foreverQuestDB.lua`
- `foreverNpcDB.lua`
- `foreverItemDB.lua`
- `foreverObjectDB.lua`

Each is a standalone Lua file returning its own ID-keyed entity table, with one entity per
line, sorted IDs and a field-index legend:

```lua
local quests = dofile("src/corrections/Forever/combined/foreverQuestDB.lua")
print(quests[2][1])
```

These are offline exports, not runtime providers or replacement TOCs. The addon does not load
them. Source files and runtime configuration are untouched. All four exports are decoded and
compared with every merged source value before any output is written. Rerunning replaces the
four generated files; do not edit them. File writes are sequential, not a four-file transaction;
rerun after fixing a filesystem error to regenerate the complete set.

## Inputs and order

1. `data/Forever/forever*DB.lua`: the independently owned, converted Era baseline.
2. `src/corrections/Forever/legacy/`: inherited Era corrections in Forever coordinates.
3. `src/corrections/Forever/generated/`: generated Forever delta-base.
4. `src/corrections/Forever/traces/`: generated trace corrections.
5. `src/corrections/Forever/forever*Fixes.lua`: authored Forever Static Corrections,
   excluded by default; opt in with `--include-authored`.

The existing registry supplies merge order, table `_add`/`_remove` semantics and provider
options. Raw `data/Classic` and `src/corrections/Era` are deliberately not mixed back in:
that would reintroduce Era coordinates and bypass Forever's independently maintained copies.

No Dynamic Corrections, Derived Passes, localization or getter normalization run. This is
merged source data, not a snapshot of character-specific public reads. Explicit zeroes,
empty strings, empty tables, sparse groups and coordinate precision survive unchanged.

## Row format

Rows use positional fields with inline `nil` holes and no trailing absent fields:

```lua
quest[123]={"Name",nil,nil,nil,20}
```

Nested values use the shared compact serializer, preserving tuple positions and map keys.
Positional rows were chosen after measuring smaller files, faster loading and lower retained
heap than explicit field-key rows on the merged data in local Linux Lua 5.1.

## Validation

Linux/WSL x64:

```sh
./tools/lua-binary/linux-x64/lua tools/export/inline.test.lua
```

Windows PowerShell:

```powershell
.\tools\lua-binary\lua.exe tools/export/inline.test.lua
```

Fixtures cover nil holes, sparse maps, late fields, escaping, exact numbers, explicit
zero/empty values, deterministic ordering and rejection of unresolved operation keys.
The real-provider check proves that applying only the four authored sets to the default
export reconstructs the opt-in export.
