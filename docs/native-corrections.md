# Native Correction providers

Corrections keep their original combined filenames. There are 45 provider files: 27 mixed,
5 pure-Static and 13 pure-Dynamic, including `Sod/sodRequiredRaces.lua`. Their 78 function
declarations live in `src/corrections/manifest.lua`.

Each provider receives the addon namespace and publishes a plain export table near its top.
Functions return Correction tables lazily. They use canonical `Meta.<Entity>.keys`, shared
`Enum` constants and the selected `Enum.corrections` tables. Before any provider loads,
`src/corrections/prepare.lua` selects shared invariant constants first, otherwise requiring
the actual flavor's declared table. Selection retains original table identities and never
fills individual keys; an empty declared table stays empty. A missing flavor enum set or
required table fails before providers export functions, register corrections or write hints.
Standalone enum/support loading does not run this flavor-dependent preparation.

Forever owns independent files and complete literal `raceKeys`, `classKeys` and `npcFlags`
tables. Its initial class/NPC values match the previously selected Classic values; races and
Skyborne masks remain unchanged. This intentional duplication allows independent future edits,
not a claim of live DBC validation. There are no enum aliases or fallback to Classic.
`flavor.rules` supplies Classic correction ordering only. Forever does not load live Era or
Shared providers.

The manifest keeps each file's Static and Dynamic declarations together. It owns file
applicability, datatype, stable registration identity, category, sequence, load-order window,
offset, expansion metadata and merge options. After selected files load, `register.lua`
passes their functions directly to the existing owner-scoped registry, without wrappers.
Seasonal files consult central policy before publishing exports or writing ObjectiveFirst
hints. Missing applicable exports and unlisted exports fail composition.

## Where to make a change

- For a data-only change, edit the existing provider function. Do not duplicate its registration
  policy in the file.
- For an applicability, Static/Dynamic classification, identity, merge, or precedence change,
  edit that provider's block in `src/corrections/manifest.lua`. Keep stable `name` values unless
  the registry identity itself must change.
- For a new provider file, add its `CorrectionProviders.<key>` export near the file header, then
  add one manifest block in the matching expansion section and intended precedence position.
  List every exported function. File-level fields decide whether the native chunk loads;
  function-level fields become registry-entry applicability and merge metadata.
- Era and Forever may reuse a provider key only for owned counterparts whose file applicability
  is mutually exclusive. Other applicable providers need distinct keys.

Regenerate the committed Source TOC after adding, moving, removing, or reordering files in the
manifest, or changing their file-level applicability (`owned`, `expansions`, or
`minExpansionOrder`). Run the central policy check, the shared suite, and Generation plus
validation for every affected flavor:

```sh
lua5.1 generate.lua toc
lua5.1 test.lua correction-authoring
lua5.1 test.lua --shared
./questiedb.sh generate Vanilla  # replace with each affected flavor
./questiedb.sh check Vanilla
```

A data-only edit does not require TOC regeneration. Use the same focused policy and flavor checks
when it changes provider output or ordering.

## Authoring example

`src/corrections/Wotlk/wotlkObjectFixes.lua`:

```lua
local _, LibQuestieDB = ...

-- Lazy exports; registration policy lives in manifest.lua.
-- Exports: Load, LoadFactionFixes.
local providers = {}
assert(not LibQuestieDB.CorrectionProviders.wotlkObjectFixes, "duplicate correction provider: wotlkObjectFixes")
LibQuestieDB.CorrectionProviders.wotlkObjectFixes = providers

---@return table
function providers.Load()
    local objectKeys = LibQuestieDB.Meta.Object.keys
    return { [269] = { [objectKeys.questStarts] = {403} } }
end

---@return table
function providers.LoadFactionFixes()
    -- Return the character-dependent corrections here, in the same file.
    return {}
end
```

The corresponding central policy, with Static and Dynamic entries next to each other:

```lua
{
  file = "Wotlk/wotlkObjectFixes.lua", minExpansionOrder = 3,
  provider = "wotlkObjectFixes", datatype = "Object",
  functions = {
    { category = "static", method = "Load", name = "Wotlk/wotlkObjectFixes.lua:Load",
      order = "WotlkStatic", offset = 11, minExpansionOrder = 3, sourceExpansionOrder = 3 },
    { category = "dynamic", method = "LoadFactionFixes", name = "Wotlk/wotlkObjectFixes.lua:LoadFactionFixes",
      order = "WotlkDynamic", offset = 11, minExpansionOrder = 3 },
  },
},
```

Edit providers for data changes and the manifest for policy changes. Keep registry names
stable. Files can export multiple Static functions: Wotlk NPC `LoadAutomatics` remains at
`WotlkStatic + 11`, followed by `Load` at `+ 12`. The authoring test reverses those central
entries and demonstrates the changed result on the real NPC 30208 spawn overlap.

## Source and Baked loading

Source mode and Generation register Static and Dynamic functions. Static Corrections still
run before Derived Passes. Baked mode selects files with a Dynamic declaration and registers
only Dynamic functions, even when loading unstripped worktree files. Static functions are
not invoked or materialized. A stripped package may omit those exports, but missing Dynamic
functions still fail.

`tools/distribution/strip-static.lua` removes only centrally declared Static definitions from
staged mixed files. It keeps shared code, Dynamic functions and hints, without Static stubs.
Pure-Static files are absent from Baked TOCs; pure-Dynamic files remain byte-identical.
Repository sources are never rewritten by packaging. The stripper requires column-zero
`function providers.Name()` and closing `end` lines, with nested blocks indented, and fails
closed on missing/duplicate definitions, compilation errors or changed native behavior.

No Correction `QuestieLoader`, fake module graph, `compat.Invoke`, capture buffers, seasonal
scope files or provider policy footers remain. Raw-data, support, localization and Derived
Pass loader shims are separate mechanisms and are unchanged. Splitting Static and Dynamic
files is a possible future improvement, not part of this transition.

## Verification after rebasing onto master

This records the rebase checkpoint before the explicit enum-ownership follow-up. It retained
master's temporary Classic class/NPC fallback, so its identity checks do not prove the final
independent ownership policy above. See [final follow-up evidence](../BRANCH_REVIEW.md#final-forever-enum-ownership-follow-up).

The current equivalence target is fetched master
`0a8472d52f7e4ff5ae9d2de33d4886be6d1d5364`. Its independent archive and observations are at
`/tmp/qdb-rebase-master-proof.FPHLqC`; rebased-native validation is at
`/tmp/qdb-validator-rebased.djK46O/README.md`.

All six generated datasets match that master exactly: 1,235,624 entity directives, including
original order. All 362 personas and 9,056 provider invocations match complete outputs,
registration metadata, options, sequence, applicability and hints. Forever's current entity
hash is `24365086d899599251ffd59a1493b410651c1ad5ad00a79d95fb770971625d1e`.

Master intentionally changes 137 Forever Quest `requiredRaces` fields versus the original
migration baseline: 136 come from providers and quest 7162 from the Derived Pass. The new
masks are `4294967373` for Alliance and `8589934770` for Horde. Nothing else in the generated
entities changes. The rebased branch preserves these changes rather than forcing old hashes.

A fresh mutation replaced one Forever provider's selected race table with Classic. The same
comparison detected exactly 136 incorrect provider and generated fields; inferred quest 7162
remained correct. Restoration returned to exact master bytes. Source, Baked and extracted
Forever/Camelot reads independently confirmed the new masks and Classic class/NPC fallback.

Validation passed 3,294 shared checks, 503 runtime/Baked/persona checks, 38 packaging tests,
21 converter tests and the real Forever distribution fixture. Six-flavor area lookups and
race validation passed. Independent review found no integration defects. Raw-data loading,
the Source reader and raw data remain byte-identical to master; that separate refactor was
not included. Full localization and live-client validation remain outside this evidence.

### Earlier migration evidence

The original immutable baseline is `d983a8025eca2e55ca1f61886307745f9db15a2c`, archived at
`/tmp/questiedb-native-corrections-proof.9AOqlG`. The final combined-layout candidate and
comparison evidence are at `/tmp/questiedb-combined-native.6O9KVl`. Its source-byte manifest,
commands and logs identify the disposable candidate. No Baked artifacts were generated in
the implementation worktree.

Using the unchanged baseline observer and serializer, all 18 scenarios, 362 personas and
9,056 provider invocations matched exactly: outputs, registration metadata, identities,
sequence, options, applicability and hints. All six complete no-localization generated entity
directive sets also matched byte-for-byte. `entities.diff` and `providers.diff` are empty.
Generation ran before the provider matrix, sequentially.

An independent final-combined validation is retained at
`/tmp/qdb-validator-final-combined.eQnMZw/evidence`. It copied and hashed the actual worktree,
including restored untracked files, then reproduced all six datasets and the full provider
matrix against the immutable baseline. All 1,235,624 directives matched, including their
original unsorted order. A fresh self-proof changed Quest 117's name in the combined Era
provider: comparison detected exactly `[117][1]` and the generated `X-Quest-117-S` row, with
provider identities and counts unchanged. Restoring the source returned both comparisons
to exact baseline bytes.

The independent pass also passed 38 packaging tests, 77 packaged-addon hint checks and 39
central-authoring checks. Real extracted Vanilla and Forever packages contained no Static
exports or pure-Static providers. Pure-Dynamic files stayed byte-identical, hints survived,
and both Forever/Camelot TOCs loaded. Review found no correctness issues; its one stale
split-layout comment was corrected. No live-client validation is implied.

Focused checks cover native Source/Baked loading, central authoring, seasonal hints, the
shared Lua suite, converter fixtures, package stripping and extracted Forever packages.
Stripping compares all applicable expansion constant shapes, both factions, all eleven class
tokens and Human/Orc branches. A negative control makes Dynamic code depend on a removed
Static function only for a Mists Horde Mage Orc; packaging must reject it.

Native DBC validation prepared ten temporary candidates from the historical recorded
coefficients: four raw files and six combined providers. It checked 140,660 coordinate pairs
and 440 provider invocations against actual source and target central policy. No DBC was
opened or downloaded and no conversion output was installed. Historical conversion/support
provenance is unchanged. Restored filenames do not restore historical bytes: the installer
continues to protect native providers as hand edits because their hashes differ.

This is one-time migration evidence, not a new permanent full-data golden gate. It excludes
full localization, live-client measurements, every race token and legal-character validation.
The provider matrix observes outputs rather than composing every Dynamic result through all
public getters; focused runtime tests cover those interfaces separately.

`.github/workflows/legacy-corrections.yml` pins the completed native migration at
`2fc6d1c9e45f90d55d94f6ce37c310fae7a4282a`. The separate CI follow-up accepts these reviewed
source changes without weakening the guard: subsequent legacy Lua edits still fail. Add new
Forever corrections in the authored `src/corrections/Forever/forever*Fixes.lua` files instead.
