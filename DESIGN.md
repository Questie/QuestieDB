# QuestieDB — Questie TOC Database

The design document this implementation was built from. Contracts decided after the
buildout live in `docs/adr/`. ADR 0003 supersedes the broad read contract, ADR 0006 owns
coordinate storage, and ADR 0010 owns Baked entity storage.

Questie's migration completed on September 18, 2026. [ADR 0014](docs/adr/0014-owned-data-after-migration.md)
supersedes the migration checks, import workflow, and derived-schema requirements below.
Prototype comparisons and the phasing section are historical, not contributor instructions.

Vocabulary is defined in [`CONTEXT.md`](./CONTEXT.md) and used precisely here.

## Mission

Replace Questie's binary/SavedVariables database with a TOC-metadata-backed database
delivered as a companion addon. Questie becomes a **consumer** of the database rather than
its owner, while retaining the ability to register Corrections.

## Locked decisions

| Decision | Value |
| --- | --- |
| Data source | **QuestieDB-owned data**, originally imported from Questie. No VibeQuest data, schema, or coordinates. |
| Schema | Questie's existing `questKeys` / `npcKeys` / `itemKeys` / `objectKeys`, unchanged. |
| Domain | QuestieDB's domain is *Questie's data model*, including Questie-specific fields. |
| Ownership | QuestieDB owns the database. Questie owns what to do with it. |
| Repos | Two repos, two addons, two independent version streams. |
| Dependency | Hard `## Dependencies: QuestieDB`. The client's red warning covers absence; the contract version covers mismatch. |
| Runtime modes | **Source mode** and **Baked mode**, selected automatically by TOC suffix precedence. |
| Variants | SoD / Classic+ are Dynamic Correction sets over the Era database, not separate databases. |
| Localization | Baked into the TOC alongside entity data. |
| Value ownership | Caller-owned. Table reads return a **fresh mutable copy** per read (ADR 0003 D10, revised after live measurement — originally "Frozen values"). |
| Engine base | `toc-database`'s generator, retargeted at Questie's schema. |
| Schema reference | `Getters` — already encodes Questie's field layout, though **stale** (32 fields vs Questie's current 36). |

`toc-database` and `Getters` were prototypes used during migration. **QuestieDB owns the
current schema and data.**

## Ownership

### Moves into QuestieDB

| What | Today |
| --- | --- |
| Raw entity data | `Database/{Classic,TBC,Wotlk,Cata,MoP}/*DB.lua` (20 files, git-tracked) |
| Schema / field keys | `Database/{quest,npc,item,object}DB.lua` → a `Meta` layer |
| Data corrections | most of `Database/Corrections/*Fixes.lua` |
| Corrections registry | `QuestieCorrections:Initialize` / `MinimalInit` |
| Entity localization | `Localization/lookups/<Expansion>/lookup{Quests,Npcs,Objects,Items}/*` plus entity rows from `lookupOverrides.lua` |
| Support data | `Database/Zones/data/`, `QuestXP/DB/`, `DropTables/data/`, `FactionTemplates/` |
| Data validators | `cli/validators.lua`, `cli/validate-*.lua` |
| Icon / enum constants used by corrections | `Questie.ICON_TYPE_*` |

### Deleted outright

- `Database/compiler.lua` (1367 lines)
- The SavedVariables database — `Questie.db.global.{npc,quest,obj,item}{Bin,Ptrs}`
- The entire parallel SoD database — `Questie.db.global.sod.*`
- `dbIsCompiled`, `dbCompiledOnVersion`, `dbCompiledLang`, `dbCompiledExpansion`,
  `dbCompiledCount`, and the `QUESTIE_DATABASE_ERROR` recompile dialog
- The `*CompilerTypes` / `*CompilerOrder` tables
- The in-game "Questie DB is updating" compile pass

### Stays in Questie

| What | Why |
| --- | --- |
| `QuestieDB.lua` semantic layer — `GetQuest`, `IsDoable`, `IsComplete`, tag info, race/class masks | Game logic, not storage |
| Support **logic** — `zoneDB.lua`, `QuestieXP.lua`, `dropDB.lua` | `QuestieLoader` modules with runtime behaviour; they read data from the lib |
| Blacklists — `hiddenQuests`, `questItemBlacklist`, `questNPCBlacklist`, `HardcoreBlacklist` | Hiding is consumer policy, not a database fact |
| Consumer-selected corrections — display suppression, calendar/location state, phases, settings, projections, caches, asynchronous Item repair | Depend on Questie-owned runtime state or policy; moving them would invert the dependency |
| `Localization/Translations/*` and `l10n("...")` | UI text |
| `lookupZones`, `lookupQuestCategories` | Zone/category names, not entity data |
| `Constants.lua`, `MeetingStones.lua` | Small, and Questie's own concepts |
| Map, tracker, tooltips, everything above the seam | Unaffected |

### Generation inputs

QuestieDB reads its owned entity, correction, support, and localization sources directly.
These were imported from Questie's tracked files without an intermediate export format.
Generation and validation require no external Questie checkout.

| Input | Shape | Loading |
| --- | --- | --- |
| `Database/<Exp>/<x>{Quest,Npc,Item,Object}DB.lua` | `QuestieDB.questData = [[return {...}]]` | mock `QuestieLoader`, execute, `loadstring` the inner string |
| `l10n/<Exp>/lookup*/<locale>.lua` | owned copies of locale-guarded Questie lookup files | stub `GetLocale()` once per locale in a private environment |
| `l10n/lookupOverrides.lua` | locale-gated whole-row entity translation replacements | fold applicable Quest/Item rows into Base translations; Titan Dynamic translations already live in `src/l10n/Titan/zhCN.lua` |
| `Database/Zones/data/`, `QuestXP/DB/`, `DropTables/data/`, `FactionTemplates/` | `QuestieLoader:ImportModule(...)` then table assignment | same mock |

Every input is already Lua, so this is a **mocked-environment loader, not a parser**. Questie's
`cli/apiMocks.lua` and `cli/loadTOC.lua` (172 lines together) already do exactly this — it is
how `validate-era.lua` loads the database today — and they move here with the validators.

`questKeys` is defined *inside* each data file. Generation checks those keys against the
canonical schema in `src/meta/` and rejects disagreements or undeclared row fields.

**Do not build on the prototypes' intermediate format.** `Getters/data/*.lua-table` is
`GetterDB`'s output, with corrections **already applied** by a pipeline QuestieDB replaces.
Using it would double-apply corrections from the wrong system. It is a dead end, not an asset.

### What to mine from the prototypes

`GetterDB` has the better *functions*; `toc-database` and `Getters` have the better *shape*.
Take accordingly.

| Take | From | Why |
| --- | --- | --- |
| `Meta/DumpFunctions.lua` | GetterDB | The Lua serializer remains offline tooling only. ADRs 0010 and 0011 replaced entity and localization literals with deterministic CBOR. |
| `dumpCoordinatesV2`, `dumpTriggerEndV2`, `dumpExtraObjectivesV2` | GetterDB | Domain-specific compaction for the fields that dominate artifact size. |
| `Corrections/Corrections.lua`, `Enum/`, `Icons.lua` | GetterDB | The registry, load-order namespaces, and the constants corrections reference. |
| Config-driven pipeline shape, TOC emission, chunking, `verify.lua` | toc-database | Explicit type/version enumeration instead of directory scanning. |

| Reject | Why |
| --- | --- |
| The `.lua-table` intermediate stage | Produces the dead-end format above. QuestieDB goes raw → corrections → TOC in one pass. |
| `require("lfs")` | GetterDB depends on LuaFileSystem, a **C module**. `Getters/generate.lua` is pure Lua and proves it is avoidable by enumerating inputs in config. Keeping the generator dependency-free preserves the option of shipping a bare `lua` binary for contributors. |
| `mangos_translation`, `translations` | Questie's lookups are taken as-is. |
| `Meta/*Meta.lua` field ordering | Served the compiler's skip-map. QuestieDB uses Questie's current positional indices in scalar rows and table keys instead. |

Deterministic serialization is a requirement, not a preference: without it, every regeneration
produces a spuriously different 85 MB artifact, making releases unreviewable and checksums
meaningless.

### The boundary rule

> **QuestieDB owns what is true about game entities. Questie owns what to do with that truth.**

A Correction fixes what is *true* — a wrong coordinate, a missing prerequisite. QuestieDB
may select a Dynamic Correction only from provider-owned data or generic character/game facts
it determines itself: class, race, faction, expansion, and season. A Correction selected or
constructed from consumer-owned runtime state or policy belongs to that consumer and is
registered through its owner-scoped registrar.

Display suppression is one example: quest 7462 genuinely exists in `quest_template`; that
Questie hides it as a duplicate is Questie's decision, and another consumer may legitimately
want it. Calendar/location representation, Questie phases and settings, projections and
caches, and asynchronous Item repair follow the same ownership rule.

## Schema

`src/meta/*Meta.lua` owns each entity's positional keys, storage types, structures, defaults,
and constant placeholders. Edit these committed tables directly; compiler-type derivation
and `generate.lua meta` retired with the migration tooling (ADR 0014).

Generation validates data-file key enums against the owned schema. A missing trailing field
is allowed only while the data file carries no values beyond its declared fields. Update
affected data keys, correction constants, and public LuaLS declarations alongside schema changes.

Legacy width and signedness do not define storage: CBOR encodes Lua values directly. Structured
fields still need explicit normalization, including coordinate tuple shape and nested numeric
nil defaults. Public `compilerTypes` metadata remains for compatibility, not derivation.

## The seam

Questie's runtime database surface, by call-site count (raw grep, includes tests):

| Surface | Sites |
| --- | --- |
| `Query*Single(id, key)` | ~290 |
| `Query*(id, keys)` | ~10 |
| `*Pointers[id]` | ~22 |

Raw `questData` / `npcData` / `itemData` / `objectData` access (~530 sites) sits in `cli/`,
`Database/Corrections/`, and `Localization/` — all compile-time paths that are moving or
being deleted.

The replaceable surface is **12 functions**: `QuerySingle`, `Query`, and `pointers`, per
entity type. Nothing above the seam changes.

### Nil and empty semantics — match Questie exactly

**Preserve the established consumer read contract.** It originated from Questie's compiler
semantics, with the explicit exceptions recorded in the storage format and later ADRs.

| Source value | Read back as |
| --- | --- |
| number `nil` | **`0`** — writers emit `value or 0`; lossy and deliberate |
| string `nil` | `nil` |
| string `""` | `""` — distinct from nil, must survive |
| table `nil` **or** `{}` | **`nil`** — empty tables never come back |
| pair `{0, 0}` | `nil` — Questie's documented hack |
| unknown entity ID | `nil` |

Two implementation consequences:

- **Numeric getters default to `0`, never `nil`.** `0` is truthy in Lua, so consumers already
  test `~= 0`; returning `nil` would change behaviour at every one of those sites.
- **Table getters return `nil`, never an empty table.** The prototypes' `EMPTY` sentinel
  (`{"startedBy", "table", EMPTY}`) contradicts this and is removed. It is independently
  disqualified anyway — a frozen table carrying `__newindex` redirects writes rather than
  failing.

**Amended by [ADR 0005](./docs/adr/0005-element-level-nil-semantics.md), after the reference
differential measured it.** Two corrections to the table above: the `questgivers` and
`objectives` structures read back as `{}` rather than nil, because their compiler readers
build a table unconditionally — so quest `startedBy`, `finishedBy` and `objectives` are never
nil for a quest that exists. And the `nil number -> 0` rule is **element-level, not
field-level**: absent numeric slots inside `objective`, `spellobjective`, killcredit and
`extraobjective` tuples read back as `0` too. Between them these accounted for 94% of every
divergence from Questie's compiler.

Literal behavior fixtures and whole-database verification protect these rules. Full detail in
[`docs/storage-format.md`](./docs/storage-format.md).

## Two runtime modes

The client searches for flavour-suffixed TOCs first and falls back to `AddonName.toc` **only
if none are found**. That rule selects the mode automatically, at no cost — a generated
artifact wins simply by existing.

| Client | TOC |
| --- | --- |
| WoW Classic | `QuestieDB_Vanilla.toc` |
| Burning Crusade Classic, Classic Anniversary | `QuestieDB_TBC.toc` |
| Wrath Classic, **Titan Reforged** | `QuestieDB_Wrath.toc` |
| Cataclysm Classic | `QuestieDB_Cata.toc` |
| Mists of Pandaria Classic | `QuestieDB_Mists.toc` |
| none of the above present | `QuestieDB.toc` → **source mode** |

Use these modern underscore suffixes. `-WOTLKC` and `-BCC` are recognised legacy forms and
are what the prototypes emit, but there is no reason to start on deprecated names.
`_Classic` and `_Mainline` are lower-priority catch-alls and are deliberately unused — a
`_Classic` TOC would lose to `_Vanilla` anyway.

Note `_Wrath` serves Titan Reforged as well as Wrath Classic, which Questie distinguishes at
runtime through its own flag rather than through separate data.

| | Source mode | Baked mode |
| --- | --- | --- |
| TOC | base `QuestieDB.toc` (committed) | `QuestieDB_Vanilla.toc` etc. (gitignored, generated) |
| Reads resolve from | raw entity data | TOC metadata store |
| Static Corrections | applied live | already folded in; files absent |
| Requires | nothing but a clone | a bootstrap download or local Generation |

A fresh clone junctioned into `AddOns` is a working development environment with **no
download and no Lua toolchain**. Generating or bootstrapping the suffixed TOC switches the
same folder to Baked mode.

**Mode must be unmistakable in-game.** Source mode gets a permanent visible indicator — on
the map or in Questie's settings — not just a login message.

### Sharing the code path

The backend seam is narrow:

| Shared, written once | Both modes | Baked fast paths |
| --- | --- | --- |
| Named getters and generic `Get` | `readField(id, fieldIndex)` | `scalarRow(id)` |
| Correction and l10n overlays | `getAllIds()` | `tableProducer(id, fieldIndex, row)` |
| Cache, defaults and Name index | | |

Source reads `rawData[id][fieldIndex]`. Baked mode decodes one scalar row on first touch and
uses the row's presence mask before reading a table key.

Source mode and Generation apply Static Corrections through the *same* path, so "what I see
in dev is what ships" follows from shared code rather than from a test.

## Corrections

### Model

Two categories, declared by the author. There is no automatic promotion, and therefore
nothing that can misfire.

- **Static Correction** — folded in during Generation. Never shipped to end users.
- **Dynamic Correction** — applied at query time through the **Correction Overlay**.
  QuestieDB-owned sets may depend only on provider-owned data or generic class, race, faction,
  expansion, and season facts QuestieDB determines itself. Consumer-owned state and policy
  stay in that consumer's owner-scoped layer.

`GetterDB/Corrections/Corrections.lua` is the starting point and most of it survives: the
registry, per-expansion load-order namespaces, collision handling, corrections held behind
functions so data materialises only on apply, and `wipe()` after deferred registration.

Fix while porting: `Sod/base/*.lua` passes a literal `70` rather than `SoDBaseDynamicOrder`
(300), so despite the comment "Sod will always load last" it applies *before* Era's faction
fixes at 120. Also `Sod/static/sodItemQuestStartFixes.lua` sits in a folder named `static`
but registers dynamic — folder names are not a reliable category signal.

### Read semantics — one shared view

Every consumer reads the same data. There is no per-consumer view.

```
                base data (raw or baked)
                          |
   layer: QuestieDB Dynamic Corrections   (faction, SoD)
                          |
   layer: Questie                          (events, phases, Quel'Danas)
                          |
   layer: SomeOtherAddon
                          |
                  composed view  <--  every consumer reads this
```

A Correction fixes wrong source data — that is not one consumer's opinion. And a third-party
addon registers a Correction *precisely so Questie displays it*.

Corrections never write into base data at runtime; the Overlay is a read-time lookup, so an
untainted base exists by construction. Writing into data happens only during Generation,
offline.

### Owner scoping

Registration is owner-scoped, and application is too:

```lua
LibQuestieDB.ApplyRegisteredCorrections()           -- every pending owner
LibQuestieDB.ApplyRegisteredCorrections("Questie")  -- one owner
```

This is required by load order, not a convenience: third-party addons declare
`## Dependencies: Questie` and therefore register *after* Questie has already applied.

Consumer-state corrections skip the function-and-apply shape entirely: `registrar.Set(datatype,
name, rows)` writes a data slot through the same registry — replace by rewriting, withdraw with
`nil`, published immediately, recomposed and invalidated per datatype, no `loadOrder`. Function
registration remains for QuestieDB's own ported sets and for large lazy tables (ADR 0009).

The owner parameter selects **which layer is being refreshed**, never which layers are
visible. Recomposition always includes every live layer.

Precedence is two-level — outer by owner rank, inner by `loadOrder` within an owner. **An
owner's rank is fixed at its first apply or first `Set`; re-applying or re-writing refreshes
that owner's layer in place, never re-ranks it** (the original "last applied wins" let an owner-scoped state refresh
hoist a whole layer above consumer corrections; caught in review, fixed). First-apply order follows load order naturally
(`QuestieDB` < `Questie` < third-party), and must be documented, because `loadOrder` changes
meaning from "global sequence" to "sequence within an owner".

### Layers, recomposed on apply

Keep per-owner layers and **recompose** the composed view on apply, rather than resolving
layers at read time:

- Read path stays a single lookup behind the `Decoded field cache`.
- Recomposition is O(total corrections) but runs only on init and setting changes.
- **Idempotent by construction** — re-applying rebuilds from the registry instead of
  accumulating into it.

That last property fixes a latent weakness in today's `addOverride`, which merges into the
override table and can only add or replace, never *remove*. It also composes cleanly with
freezing: a fresh object per recomposition can be frozen without conflict.

### Correction origin

The generator runs offline with only QuestieDB present, so it bakes only corrections owned
by QuestieDB. Anything registered by Questie or a third party is Dynamic by definition, and
the generator can enforce this rather than trusting convention.

### `extraObjectives` and translated text

`l10n(...)` appears ~100 times in `classicQuestFixes.lua` and ~207 times in
`tbcQuestFixes.lua`, always inside `extraObjectives`, alongside `Questie.ICON_TYPE_*`.

**Store the enUS string, translate at render time.** Questie's `l10n()` is keyed by the
English string, so output is identical. `GetterDB` already anticipated this — its correction
files stub `local function l10n(s) return s end`.

### Conflict visibility

Recomposition is the natural place to detect silent clobbering. A debug mode should log
`owner "MyAddon" overrode "Questie" on quest 123 field objectivesText`, with `GetOwners()`
exposing applied order.

## Public API

```lua
-- Data access (the 12-function seam)
LibQuestieDB.Quest.Get(id, key) / .GetAll(id, keys) / .GetAllIds(hashmap)
-- × Npc, Item, Object

LibQuestieDB.Quest.GetRaw(id, key)             -- base data only, bypasses layers
LibQuestieDB.GetProvenance(datatype, id, key)  -- which owner supplied the winning value

-- Schema
LibQuestieDB.Meta.QuestMeta.questKeys

-- Corrections
LibQuestieDB.Corrections.RegisterCorrection(owner, datatype, name, func, loadOrder)
LibQuestieDB.Corrections.RegisterRuntimeCorrection(owner, datatype, name, func, loadOrder)
LibQuestieDB.Corrections.GetRegistrar(owner)   -- optional wrapper

-- Lifecycle
LibQuestieDB.ApplyRegisteredCorrections(owner?)
LibQuestieDB.InvalidateCache(datatype, id)

-- Contract
LibQuestieDB.contractVersion
```

### Initialization order

QuestieDB loads before Questie, so it cannot apply Questie's Corrections at its own load
time:

1. **QuestieDB loads.** Registry available, base data queryable immediately.
2. **Questie loads and registers** its policy Corrections.
3. **Questie calls `ApplyRegisteredCorrections("Questie")`** in its staged init — roughly
   where `QuestieCorrections:MinimalInit()` sits today — then queries.

Prefer this explicit call over `GetterDB`'s `C_Timer.After(0, …)` frame timing. Registering
later must remain legal, which is what `InvalidateCache` is for.

### Contract version

Independent release cycles make skew inevitable. The hard `## Dependencies` covers *absence*;
it does not cover *presence with the wrong version*. Questie checks `contractVersion` at init
and fails with a specific message. This replaces `QUESTIE_DATABASE_ERROR` as the "your
database is wrong" path.

## Value ownership

**Superseded by [ADR 0003 Decision 10](./docs/adr/0003-merged-storage-and-read-contract.md),
revised after live measurement.** This section originally mandated frozen shared values; what
ships is the opposite, and better on this design's own terms.

Table reads return a **fresh mutable copy per read**. Baked mode caches a producer over CBOR
bytes and calls the client's native deserializer for each read. Source mode, Corrections and
translated values cache deep-copy producers. Scalars remain immutable; Baked mode caches the
whole decoded scalar row on the entity's first field read.

Why the reversal, in short (full numbers in
[`docs/client-metadata-probes.md`](./docs/client-metadata-probes.md)):

- **Fresh-per-read is Questie's existing semantics.** The compiler decodes fresh tables per
  call, and the ~290 call sites were written against that — sites like `GetQuest`'s
  `creatureObjective[3] = nil` stay harmless, and the consumer-side mutation audit this
  section used to require disappears entirely.
- **The original rejection reason is measured away.** Native CBOR decode returns a fresh tree
  without lexing, parsing or compiling Lua source. Typical warm tables remain in the same
  cost class as the former compiled-chunk producer.
- **Frozen values never held in Baked mode.** `table.freeze` is taint-ownership gated, and the
  earlier literal chunks belonged to the force-taint context. Native CBOR now supplies the
  caller-owned tree directly.

`table.freeze` remains in use only for QuestieDB-internal shared structures (schema meta,
ID maps), where addon ownership makes it real. `docs/table.freeze.md` holds the underlying
API research, including the `__newindex` redirect hazard that still forbids metatable-carrying
sentinels anywhere near frozen internals.

## Localization

Questie today bakes locale into the compiled binary: `l10n:Initialize()` writes translated
strings into `questData` *before* compile, and `dbCompiledLang` forces a full recompile when
the UI locale changes.

Replace with the l10n overlay and `SetLocale()` at runtime. **This deletes the
recompile-on-locale-change entirely.** ADR 0011 stores one compressed CBOR column block per
locale and entity type. The columns align with the entity backend's ascending ID list, so they
repeat no IDs. enUS decodes no localization. A non-enUS client decodes four blocks during addon
load and keeps that locale's translations in memory.

Two contracts remain load-bearing. **The active non-English translation is authoritative for a
translatable field:** Dynamic Translation Corrections win first, then the Base translation with
Static Translation Corrections folded in, then normal corrected and base entity values. `enUS`
bypasses localization, and fields outside the localization field set never enter that stack
(ADR 0013). **Table-typed fields keep their table shape:** CBOR stores `objectivesText` as a list,
including legitimate locale-specific element counts, and the shared copy producer still returns
a fresh mutable table on every read.

l10n stays **inside** the QuestieDB TOC rather than becoming a separate addon. Compression
across whole field columns removes about 65% of localization directive bytes. The retained
active-locale heap is the deliberate trade: 3.2 to 4.1 MB on Vanilla and 14.2 to 18.4 MB on
Mists. The inactive eight locales remain compressed metadata and never enter the Lua heap.

The nine stored locales are `deDE, esES, esMX, frFR, koKR, ptBR, ruRU, zhCN, zhTW`; base data
is already enUS. Field coverage is quest `name` + `objectivesText`, npc `name` + `subName`, item
`name`, and object `name`. Localization has three inputs: Base translations, Static Translation
Corrections folded into generated blocks, and Dynamic Translation Corrections selected at query
time. Source mode omits ordinary Base translations but can apply Dynamic Translation Corrections.

## Variants: SoD, Classic+

SoD and Classic+ are an in-game flag over Era, not separate clients. They are Dynamic
Correction sets over the Era database — which is what `Sod/base/sodBase*.lua` already does.
No separate generated database.

This deletes Questie's entire parallel compiled database for SoD, halving both compile time
and SavedVariables footprint. The cost is SoD base tables staying resident rather than baked.
Accepted: performance loss is fine for variants that are only a flag apart.

## Packaging and release

Two repos, two addons, two version streams. Questie's `build.py` already does per-flavor
packaging (`ignorePatterns.append(expansionStrings[i])`) and emits a `release.json` multi-flavor
manifest — QuestieDB mirrors that discipline rather than inventing one.

QuestieDB ships **bundled** inside Questie's zip and may also publish standalone.
`release.json` already carries `"nolib": false`, which is CurseForge's mechanism for exactly
this case: a `-nolib` variant lets standalone installers avoid a folder collision.

### Release-backed data bootstrap

Baked TOCs are **never committed**. Successful default-branch builds update one rolling
`preview` pre-release. A manual full release uses `vX.X.X` from the maintained `## Version:`
in `QuestieDB.toc`, rejecting an existing tag or release unless the maintainer explicitly
selects `override`. The manifest carries the producer commit, per-artifact SHA-256, and the
contract version. Owned localization is identified by
the producer commit. See [release operations](./README.md#releases) for publication
ordering, failure recovery, and local version selection.

A bootstrap script — PowerShell or bash, no Lua — installs artifacts into the gitignored TOC
slot in the developer's clone. Deviations from the generic pattern: the install target is
`Interface/AddOns/QuestieDB/` rather than a project cache dir, and **all flavors are
downloaded** so switching test clients needs no re-bootstrap.

### Measured sizes

Deterministic contract-2 artifacts after ADRs 0010 and 0011, in decimal bytes:

| Flavor | Raw TOC bytes |
| --- | ---: |
| Vanilla | 13,019,881 |
| TBC | 21,242,139 |
| Wrath | 29,900,504 |
| Cata | 47,360,651 |
| Mists | 57,111,494 |
| **All five** | **168,634,669** |

Compressed localization columns remove 113,654,275 bytes, or 40.3%, from the contract-2
artifacts. Mists localization directives alone fall from 57.48 MiB to 19.80 MiB. Package ZIP
sizes are produced by the release workflow and were not remeasured in this acceptance pass.

The compressed ID headers add 2.82 MB of fixed memory attributed to QuestieDB on Vanilla.
The decoded arrays and existence maps are retained for the session and create no recurring
GC work. ADR 0010 accepts that cost in exchange for portable typed storage and the measured
40% reduction in Questie's `CalculateAndDrawAll` workload.

Historical measurements remain useful for comparison:

| Format | Vanilla | Mists | All five |
| --- | ---: | ---: | ---: |
| Post-ADR-0006 literals | 21,860,697 | 102,430,533 | 297,290,054 |
| Early prototypes | 20.4 MB | 84.5 MB | 251 MB |

### Generation cost

| Contract-2 generation | Time |
| --- | ---: |
| Vanilla, including l10n | 34 s |
| Mists, including l10n | 168 s |
| All flavors in the memory-budgeted check runner | 168 s wall time |

Generation is pure Lua with no C dependencies. Windows and Linux x64 contributors can use
the bundled interpreters through `generate.sh` or Windows' `generate.cmd` without installing a
toolchain. macOS uses an installed Lua 5.1 interpreter. Source mode still covers the dev loop
without Generation.

## Module layout

```text
QuestieDB/
  QuestieDB.toc              base TOC — source mode (committed)
  QuestieDB_<Flavor>.toc     generated, baked mode (gitignored)

  src/
    config.lua                flavors, entity types, l10n block contract
    meta/                     schema, field keys, types, defaults, chunk markers
    read/
      shared.lua              getters, row cache, overlay lookup, defaults, freezing
      source.lua              readField/getAllIds over raw tables
      baked.lua               CBOR rows, table producers and compressed ID headers
    corrections/
      registry.lua            Register / Apply / load-order / recomposition
      <expansion>/            Static and Dynamic Corrections
      enum/, icons.lua        constants corrections reference
    l10n/                     eager active-locale columns and lookup
    types/                    LuaLS annotations

  data/                       raw entity data, moved from Questie
  l10n/                       owned entity translations and static lookup overrides
  support/                    zones, questXP, dropTables, factionTemplates

  generate.lua                data + Static Corrections -> TOC
  verify.lua                  round-trip verification
  validators/                 data-invariant checks, moved from Questie cli/
  emulator/                   metadata emulator + mocked-env loader
  test.lua                    decoder and equivalence tests

  docs/
    storage-format.md         the on-disk contract
    table.freeze.md           live-client freeze research
    adr/
```

`src/read/` is the only place the two modes diverge. `shared.lua` holds everything else;
Baked mode adds scalar-row and table-producer fast paths to the two-function base seam.

## Testing

Current provider checks have two purposes:

- Small fixtures with literal expected values protect storage semantics, correction ordering,
  expansion inheritance, seasonal admission, localization, and Derived Pass behavior. Expected
  results are reviewed, not regenerated from the implementation.
- Whole-database checks validate current inputs and artifacts: round-trip Verification,
  Source/Baked equivalence, byte-exact Reconstruction, data invariants, determinism, and
  ownership checks. Packaging also verifies that stripping Static Corrections preserves behavior.

Compiler comparisons, imported-data fidelity checks, and full-data golden snapshots served the
migration and are removed. They are available at the migration checkpoint, not as optional gates.
Ordinary data changes do not require snapshot refreshes. These checks protect contracts but do
not prove that every gameplay fact is correct.

See [the contributor commands](README.md#the-full-toolchain) and
[independent test scopes](README.md#independent-test-scopes).

## Open risks and gates

### 1. TOC size in the live client: cleared; Mists is 57.1 MB

Previously the blocking gate. **Resolved by prior in-client testing**: both `toc-database` and
`Getters` were tested deeply against real clients at full size and load fast, with no parse or
memory problem at the 20–85 MB range. The merged Vanilla artifact (25.4 MB) is additionally
live-validated end-to-end on build 69109
([`docs/client-metadata-probes.md`](./docs/client-metadata-probes.md) §7b).

ADR 0011 reduces the Mists artifact to 57,111,494 bytes, below the historically cleared
85 MB range. Its active non-enUS locale retains 14.2 to 18.4 MiB in the Era-client prototype
and takes 71 to 128 ms to decode. A Mists-client acceptance session for full load and
client-wide memory remains open in [issue #6](https://github.com/Questie/QuestieDB/issues/6).

This settles the l10n-in-TOC decision. Keeping all nine compressed locales in the store costs
less artifact and metadata memory than the earlier joined format, while enUS decodes none.
Splitting l10n out remains available if the artifact grows substantially beyond today's size.

Consequence for the rest of the plan: **the prototypes' runtime behaviour is validated**, which
raises the value of extracting their format precisely — see
[`docs/storage-format.md`](./docs/storage-format.md).

Generated and intermediate data is disposable: `Getters/{Database}` and `Getters/data/` are
untracked derived output. `Getters` and `toc-database` themselves are recoverable from their
remotes. **`GetterDB` is not** — it is a nested repository with no remote, and must be
preserved before the folder around it is removed. See phase 11.

### 2. `*Pointers` semantics — audit

The ~22 `*Pointers` sites need checking to confirm they only test existence and iterate ids.
`GetAllIds(true)` returns a real hashmap and is a drop-in *if* that holds.

### 3. Schema consistency

Generation checks the owned schema against data-file key enums and rejects undeclared fields.
Schema changes also require corresponding public declaration changes. External compiler-type
derivation is no longer a validation source; see ADR 0014.

### 4. Mutation audit — MOOT

Retired with the frozen-value contract itself: ADR 0003 D10 (revised) made every table
read a fresh mutable copy the caller owns — Questie's original semantics — so consumer
mutation sites like `GetQuest`'s are harmless by construction and no audit is needed.

## Rejected alternatives

Recorded so they are not re-derived. Each was seriously considered and rejected for a
specific reason.

**`hidden` as a schema field.** Blacklisting would become an ordinary Correction
(`[7462] = {hidden = true}`), collapsing two mechanisms into one and giving blacklists the
whole correction lifecycle including the dev loop. Genuinely more elegant, and the right
answer in a greenfield design. Rejected because `hiddenQuests[id]` is a single table index in
the hottest availability loops, and turning it into an overlay check plus a metadata decode
regresses the exact path this design protects. Separately, hiding is consumer policy and not a
database fact — see the boundary rule.

**Automatic promotion via an `X-TDB-BAKED` manifest.** Generation would record which
corrections it folded in, with per-correction hashes; the runtime would apply any registered
correction absent from the manifest, so a new correction worked immediately and "promotion"
was just regeneration. Rejected because it only existed to make promotion automatic, and once
the author simply declares Static or Dynamic there is no promotion step to automate. It would
have added per-correction hashing, a manifest format, and a `Pending` lifecycle state to solve
a problem that no longer exists.

**An overlay-based dev addon.** Static Corrections loaded through the Correction Overlay so
contributors could skip Generation. Superseded by source mode, which is strictly better on
two counts: an overlay can add and change but **never remove**, so deleting a correction is
untestable through it; and source mode shares the generator's correction path rather than
being a parallel one.

**Frozen shared read values.** Rejected after live measurement. Callers already expect fresh
mutable tables, and native CBOR returns them without a Lua parse. Freezing would change the
public ownership contract and does not work reliably for values owned by another execution
context.

**Splitting localization into its own addon.** Would let English users skip the compressed
locale blocks. Rejected because ADR 0011 removes about 65% of localization directive bytes,
enUS decodes no blocks, and a second addon would add packaging and dependency complexity for
little runtime benefit. It remains the first lever to pull if artifact size grows again.

**Keeping raw data in Questie.** Rejected: the generator would need Questie checked out to
build, and support-data validators such as
`checkNpcSpawnAreaIds(npcs, npcKeys, getUiMapIdByAreaId)` could not run without it.

**A hand-written schema during migration.** Originally rejected while Questie still owned and
changed the schema. Derivation caught import drift then. After cutover, `src/meta/` is the
canonical owned schema; keeping derivation would make the retired compiler an authority over
the new database. ADR 0014 supersedes the original rejection.

## Verified findings

Checks already performed, recorded so they are not repeated.

**Consumer-owned runtime state stays at the consumer boundary.** Calendar/location
representation, display suppression, phases and settings, projections and caches, and
asynchronous Item repair are Questie-owned even when they ultimately construct entity-field
Corrections. Questie registers those values through its generic owner-scoped registrar; no
consumer-specific dispatch or state model belongs in QuestieDB.

**The mutation hazard is aliasing, not copying.** `QuestieDB.GetQuest` assigns
`QO[stringKey] = rawdata[intKey]`, so the Quest object holds a *reference* to the query
result rather than a copy. That is what lets `creatureObjective[3] = nil` reach the database.
When auditing under freezing, this assignment pattern — not the `= nil` write — is what to
search for.

## Historical migration phasing

The plan below records the original sequencing. The cutover is complete; ADR 0014 retires its
comparison and snapshot requirements. It is not a current release checklist.

The ordering constraint that matters: **the compiler is the reference implementation, so it is
removed last** — after the differential test runs clean and its golden snapshot is committed.

1. **Tracer bullet.** One entity type, one flavor, end to end: generate `QuestieDB_Vanilla.toc`
   from Questie's `classicQuestDB.lua`, load it in-game, and read `QuestDB.name(2)` →
   `"Sharptalon's Claw"`. Pierces loader, serializer, TOC emission, decoder, and in-client read
   in one thin slice. Every later phase widens it.
2. Port the `toc-database` engine here, retargeted at Questie's schema. Move the `Meta` layer.
3. Build the metadata emulator and round-trip verification.
4. Build source mode and baked mode behind the shared getter API. Establish the equivalence test.
5. Introduce the backend interface in Questie behind a flag; the compiler stays default.
6. Differential test until clean. **Commit the golden snapshot.**
7. Move data corrections, Support data, and validators here. Build the registry and dev loop.
8. Expose the public API; convert Questie's policy corrections to registered Dynamic Corrections.
9. Move entity l10n to the overlay; delete the `dbCompiledLang` recompile trigger.
10. Set up CI, release-backed bootstrap, and the pinned integration job.
11. **Retire the prototypes to `.retired`.** Once the engine (step 2) and the corrections
    registry (step 7) are ported, move `Getters` and `toc-database` into a gitignored
    `.retired` folder at the workspace root. They are moved, not deleted — retiring is
    reversible, and nothing is removed from any remote.

    **`GetterDB` still needs an off-machine copy.** It is a nested git repository with **no
    remote**, holding the serializer and the corrections registry. `.retired` protects it from
    the cleanup; it does not protect it from machine loss. Push it somewhere independently —
    this is worth doing now rather than at phase 11, since it is the only irreversible failure
    mode in the plan.

    `.retired` is reference material, never a build input. In particular, nothing may consume
    the prototypes' intermediate export format — see Generation inputs.
12. Flip the default. Keep the compiler one release cycle.
13. **Materialize the compiler-type map**, then remove `compiler.lua`, the raw data files, the
    SavedVariables database, and the SoD parallel database. Questie is now a pure consumer.

    Materialization comes first because `*CompilerTypes` is the map's only source and this step
    deletes it. `*Keys` need no such treatment — the data files carry their own copy, so field
    names and ordering keep deriving afterwards.

Two independent retirements, easily confused: **step 11 removes the prototypes**
(`Getters`, `toc-database`), and **step 13 removes Questie's compiler**. They gate on
different things and must not be collapsed.

**If QuestieDB is merged only once step 13 is complete**, step 12 never ships and collapses
into 13. That is a reasonable choice given how thoroughly the approach has been tested, but it
removes the in-the-wild fallback: there is no released build where a user can flip back to the
compiler. The golden snapshot from step 6 then becomes the only regression guard, so committing
it stops being optional.
