# QuestieDB Public API

Everything a consumer needs, without reading the source.

QuestieDB publishes a single global, `LibQuestieDB`, plus the shorthand Entity globals
`QuestDB`, `NpcDB`, `ItemDB` and `ObjectDB`. Declare a hard dependency:

```toc
## Dependencies: QuestieDB
```

The client's red missing-dependency warning covers *absence*. It does not cover *presence with
the wrong version* — see [Contract version](#contract-version).

---

## LuaLS declarations

Release zips include analysis-only declarations in `QuestieDB/Types`. They cover the root
`LibQuestieDB` global, all entity methods, and every schema-backed named getter. WoW does not
load these files because no TOC lists them.

Add the packaged folder to the consuming addon's `.luarc.json`. For sibling addon folders under
`Interface/AddOns`, use:

```json
{
  "workspace.library": [
    "../QuestieDB/Types"
  ]
}
```

Adjust the relative path if your editor workspace uses another layout.

The declarations are a shipped API contract. Contributors must update `src/types/` when entity
schemas or getters change, or when a public signature, overload, return nilability, structured
value, Corrections interface, or localization interface changes. Internal refactors that preserve those contracts do
not require a type edit; `AGENTS.md` contains the file-by-file maintenance checklist.

---

## Reading entity fields

Four Entity globals, one per entity type, with an identical surface:

```lua
LibQuestieDB.Quest   -- also the global QuestDB
LibQuestieDB.Npc     -- NpcDB
LibQuestieDB.Item    -- ItemDB
LibQuestieDB.Object  -- ObjectDB
```

### `Entity.Get(id, key) -> value`

`key` is a canonical field name or a positional index. Both return the same value. Prefer a
name for clarity, or the generated named getter on a hot path because it skips key resolution
entirely. Baked mode decodes the entity's scalar row on its first field read; later scalar
reads from that entity are cache lookups. See [`read-performance.md`](./read-performance.md).

```lua
QuestDB.Get(2, "name")           --> "Sharptalon's Claw"
QuestDB.Get(2, 1)                --> "Sharptalon's Claw"
NpcDB.Get(54, "subName")         --> "Weaponsmith"
```

### `Entity.<fieldName>(id) -> value`

A named getter per field, generated from the schema. Identical to `Get(id, "<fieldName>")`.

```lua
QuestDB.name(2)                  --> "Sharptalon's Claw"
QuestDB.requiredLevel(2)         --> 20
NpcDB.spawns(30)                 --> { [12] = { {36.43, 55.89}, ... } }
```

NPC health is no longer stored. The deprecated `NpcDB.minLevelHealth(id)` and
`NpcDB.maxLevelHealth(id)` getters return placeholder values `0` and `1` for a known NPC.
The same placeholders apply through `Get`, `GetByIndex`, `GetRaw`, and `GetAll`. Dynamic
Corrections cannot replace or delete them. Unknown NPC IDs still return `nil`; these values are
compatibility placeholders, not health estimates.

### `Entity.GetAll(id, keys) -> values | nil`

Bulk access. Values come back in the order the keys were requested, in a **packed** table
carrying `n` — because a nullable field leaves a hole, and a bare `unpack` over a table with
holes silently drops everything after the first one.

```lua
local values = QuestDB.GetAll(2, { "name", "triggerEnd", "requiredLevel" })
local name, trigger, level = unpack(values, 1, values.n)   -- always all three
```

Returns `nil` for an unknown entity id.

### `Entity.GetAllIds(hashmap) -> list | map`

```lua
QuestDB.GetAllIds()              --> { 2, 5, 7, 12, ... }   ascending
QuestDB.GetAllIds(true)          --> { [2] = true, [5] = true, ... }
QuestDB.Exists(2)                --> true
```

The hashmap form is a drop-in for an existence check.

The hashmap and list answer over the **composed view**: an entity a Dynamic Correction adds
is readable, enumerable, and exists — all three or none. Treat both returns as read-only;
they are shared, not copies.

### `Entity.IdsByName(name) -> list | nil`

The reverse of the `name` getter: every composed id whose **current** name equals `name`
exactly, ascending, or `nil` when none does. Current means what `Entity.name(id)` returns right
now, including the active locale and any overlay-added entities, because the index behind it is
built from those reads and from nothing else.

```lua
ObjectDB.IdsByName("Old Lion Statue")    --> { 31 }
ObjectDB.IdsByName("Battered Chest")     --> { 2843, 2844, 2849, ... }   ascending
ObjectDB.IdsByName("No Such Name")       --> nil
```

The index is built on the first call and dropped whenever the cache is — a Correction apply, a
locale change, `InvalidateCache` — then rebuilt from scratch on the next call, never patched.
That is what makes a withdrawn Correction or an old locale unable to leave a stale name behind.

Building is a full pass over every entity's name: **23 ms for Vanilla's 6,666 objects** from a
cold cache in a live client, 3.5 µs per id, and it warms the name field cache for every id —
about 2.2 MB of heap for that type, kept for the session
([`client-metadata-probes.md` §9](./client-metadata-probes.md)). Mists' 20,326 objects are
unmeasured; expect roughly three times that. `Entity.BuildNameIndex()` does that pass on
demand — a no-op when the index already exists — so a consumer can pay for it where a stall is
invisible, its own init or a settings toggle, rather than on a hover path. After an
invalidation the next `IdsByName` call pays it again, and a per-entity
`InvalidateCache(datatype, id)` counts: it drops the whole index, because it can change a name.

Like `GetAllIds`, the returned list is shared and read-only.

This exists for the case where the client hands you a name and no id — a hovered world object.
It is not a substitute for a consumer's own bookkeeping: an addon that already knows which ids
it registered something for should index those, not scan the database (ADR 0008).

### `Entity.GetRaw(id, key) -> value`

Base data only, bypassing the Correction Overlay and localization. For tooling and
debugging — use `Get` for anything a player sees. An overlay-added entity has no raw row, so
`GetRaw` legitimately returns nil for it.

**`GetRaw` is not cached.** In Baked mode, every scalar call decodes the entity row again and
every table call performs a fresh CBOR decode. `Get` retains the scalar row and table producer,
so use it for loops and ordinary consumer reads.

---

## Nil and empty semantics

**These are load-bearing and match Questie's compiler exactly.** Consumers have been written
against them for years.

| Source value | Read back as |
| --- | --- |
| number nil | **`0`** — never nil |
| number `n` | `n` |
| string nil | `nil` |
| string `""` | `""` — distinct from nil |
| table nil | `nil` |
| table `{}` | **`nil`** — empty tables never come back… |
| …except `startedBy`, `finishedBy`, `objectives` | **`{}`** — these three are never nil for an entity that exists |
| pair `{0, 0}` | `nil` |
| unknown entity ID | **`nil` for every field** — including numerics |
| invalid id (`nil`, a string) | `nil`, never an error |

Three consequences worth stating plainly:

* **Numeric getters return `0`, never `nil` — for an entity that exists.** `0` is truthy in
  Lua, so test `~= 0` rather than truthiness.
* **An unknown id is `nil` everywhere.** A missing entity can never masquerade as a valid
  all-zero row; check `Exists(id)` when the distinction matters.
* **Table getters return `nil`, never an empty table — with three exceptions.** Quest
  `startedBy`, `finishedBy` and `objectives` return `{}` rather than nil when the quest has
  none, matching Questie's compiler, whose readers build those tables unconditionally. So a
  table getter is *not* a presence test for those three: check contents, not truthiness. Guard
  before indexing everywhere else.
* **Numeric slots inside structured values default to `0`, not nil.** The field-level rule
  applies element-wise: `objective[3]` (icon), `spellObjective[3]` (item),
  `killCredit[4]` and `extraObjective[4]` (objectiveIndex) are numbers, never nil. `0` is
  truthy, so test `~= 0`. String slots inside structures stay nil. See
  [`adr/0005-element-level-nil-semantics.md`](./adr/0005-element-level-nil-semantics.md).

Full detail in [`storage-format.md`](./storage-format.md).

---

## Value ownership

**Every table read returns a fresh mutable copy. You own it** (ADR 0003 Decision 10).

```lua
local spawns = NpcDB.spawns(30)
spawns[12] = nil                     --> fine: this copy is yours
local again = NpcDB.spawns(30)       --> a fresh, unmutated copy — your edit never persists
```

This matches the semantics Questie's compiler always had: every query decoded fresh tables,
so consumers that annotate or trim what they read keep working unchanged. Two reads are
never the same table. Do not use table identity to compare reads, and hold onto a value rather
than re-reading if you need stability. Baked mode gets the fresh tree from native CBOR decode;
Source mode, Corrections and translated values use deep-copy producers.

---

## Schema

```lua
LibQuestieDB.Meta.QuestMeta.questKeys        --> { name = 1, startedBy = 2, ... }
LibQuestieDB.Meta.NpcMeta.npcKeys
LibQuestieDB.Meta.ItemMeta.itemKeys
LibQuestieDB.Meta.ObjectMeta.objectKeys

LibQuestieDB.Meta.Quest.names[1]             --> "name"
LibQuestieDB.Meta.Quest.types[1]             --> "string"    -- number | string | table
LibQuestieDB.Meta.Quest.fieldCount           --> 36
```

Derived from Questie's own key enums, so a field added upstream appears here rather than
drifting.

### Phase constants

```lua
local phases = LibQuestieDB.Enum.phases
phases.HYJAL_CHAPTER_1                    --> 194  (Blizzard phase ID)
phases.HYJAL_IAN_AND_TARIK_NOT_IN_CAGE      --> 1000 (Questie-defined fake phase ID)
```

`Enum.phases` maps names to the integer IDs used in spawn data. It is available at addon load
in both Source and Baked modes, with the same constants across flavors. Treat this shared table
as read-only; do not add, replace, or renumber entries from a consumer.

QuestieDB owns the IDs, including the fake IDs used to distinguish visibility conditions that
Blizzard's reused phase IDs cannot express. Questie owns the quest-state checks that decide
whether a spawn is visible. Other properties of `Enum` remain internal.

### Objective ordering hints

Some Quest Corrections carry consumer hints about which objective type should be rendered first.
They are not entity fields, so QuestieDB publishes the five read-only ID sets separately:

```lua
LibQuestieDB.ObjectiveFirst.killCreditObjectiveFirst
LibQuestieDB.ObjectiveFirst.objectObjectiveFirst
LibQuestieDB.ObjectiveFirst.itemObjectiveFirst
LibQuestieDB.ObjectiveFirst.eventObjectiveFirst
LibQuestieDB.ObjectiveFirst.spellObjectiveFirst
```

Each table has the shape `{ [questId] = true }`. These are consumer-must-not-mutate tables;
QuestieDB publishes the underlying mutable values directly.

Base-expansion hints are cumulative: TBC includes Era hints, Wrath includes Era and TBC hints,
and so on through Mists. Forever publishes hints from its owned providers, not the cumulative
legacy providers. Seasonal hints require both their base flavor and active season. SoD hints
appear only on Vanilla with season 2 active. Titan Reforged hints appear only on Wrath
with season 109 active. Source, Baked, and static-stripped packaged addons publish the same five
tables for a given flavor and season.

A seasonal provider file may ship in a base-flavor addon because its Dynamic Corrections must be
available when that season is active. Loading the file does not publish its objective-ordering
hints when the season gate is closed. Plain Vanilla excludes SoD load-time hints even though
the files are present. [ADR 0012](./adr/0012-objective-first-applicability.md) records the
applicability boundary and its original migration rationale.

---

## Corrections

A **Correction** fixes what is *true* about an entity — a wrong coordinate, a missing
prerequisite. Deciding an entity should not be *shown* is consumer policy and does not belong
here.

Two categories, declared by the author:

| | |
| --- | --- |
| **Static** | Folded in during Generation. Only QuestieDB can register these usefully — the generator runs offline with nothing else present. |
| **Dynamic** | Applied at query time through the Correction Overlay. **This is what a third-party addon registers.** |

QuestieDB-owned Dynamic Corrections may depend only on provider-owned data or generic
character/game facts QuestieDB determines itself: class, race, faction, expansion, and season.
A Correction selected or constructed from consumer-owned runtime state or policy belongs to
that consumer. Display suppression, consumer phases/settings, projections/caches, and
asynchronous consumer-side repair are examples; register them through that consumer's
owner-scoped registrar.

### Registering

```lua
local registrar = LibQuestieDB.GetRegistrar("MyAddon")

registrar.RegisterRuntimeCorrection("Quest", "my-fixes", function()
    local questKeys = LibQuestieDB.Meta.QuestMeta.questKeys
    return {
        [2] = { [questKeys.name] = "A better name" },
        [5] = { [questKeys.preQuestSingle] = {} },   -- {} clears a field
    }
end, 10)

registrar.Apply()   -- or LibQuestieDB.ApplyRegisteredCorrections("MyAddon")
```

The long form, if you prefer not to hold a registrar:

```lua
LibQuestieDB.RegisterRuntimeCorrection(owner, datatype, name, func, loadOrder)
LibQuestieDB.RegisterCorrection(owner, datatype, name, func, loadOrder)
LibQuestieDB.Corrections.UnregisterCorrection(owner, datatype, name)
LibQuestieDB.ApplyRegisteredCorrections(owner)
```

`datatype` is `"Quest"`, `"Npc"`, `"Item"` or `"Object"` (lowercase accepted).

**The correction is a function returning the table, not the table itself.** The data
materialises only on apply, so a multi-megabyte literal never sits in memory between load and
apply, and constants the body reads are resolved at apply time.

### Correction shape

`id -> fieldIndex -> value`.

* `[key] = {}` **clears** the field — an empty table reads back as nil.
* `[key] = nil` is a **no-op**: Lua's table constructor drops it. It is documentation, not code.
* An id absent from the database is **created**, which is how a correction adds an entity.
  An added entity is fully first-class: readable, enumerable through `GetAllIds`, and
  `Exists(id)` is true, until the correction is withdrawn.
* **Correction coordinates preserve their supplied `x` and `y` values.** No compiler-grid
  quantization runs in production, so a coordinate read from the database may safely be reused.
  Ordinary tuple rules still apply: spawn phase `0` and waypoint third elements are omitted.

### Precedence

Within the corrected entity layer, the later-ranked writer wins at two levels:

* outer: the order owners **first** applied or first wrote a `Set` slot — an owner's rank is
  fixed at that first write, and re-applying or re-writing refreshes that owner's layer **in
  place**. A state refresh can therefore never hoist a layer above corrections registered later.
* inner: `loadOrder` within one owner

`loadOrder` means "sequence within an owner", not a global sequence. Load order makes the outer
level fall out naturally: `QuestieDB` < `Questie` < third-party. An active non-English
translation can replace the winning entity value for a translatable field; see
[Localization](#localization).

One idiom note: `[key] = {}` in a correction deletes the field for **every** field type — a
deleted string or table reads `nil`, a deleted number falls to the existence-gated `0`
default. A *non-empty* table written to a number- or string-typed field is an authoring
error: the write is reported and dropped.

### When to apply

QuestieDB loads before its consumers, so it cannot apply their corrections at its own load
time:

1. **QuestieDB loads.** Registry available, base data queryable immediately, QuestieDB's own
   layer applied.
2. **Your addon loads and registers.**
3. **Your addon calls `ApplyRegisteredCorrections("MyAddon")`** in its init, then queries.

The owner parameter selects **which layer is being refreshed**, never which layers are visible —
recomposition always includes every live layer. Registering later stays legal; call
`ApplyRegisteredCorrections` again, or `LibQuestieDB.InvalidateCache(datatype, id)`.

Re-applying is **idempotent**: the composed view is rebuilt from the registry rather than
accumulated into, which is also what makes a *withdrawn* correction actually disappear.

Re-applying an owner re-runs **that owner's** provider functions; every other owner's layer
reuses its memoized materialization. Recomposition and cache invalidation are scoped to the
datatypes the refreshed entries touch — an Item-only apply leaves Quest, Npc, and Object read
caches, shared ID maps, and Name indexes untouched (ADR 0009).

### Data-shaped corrections: `Set`

For a correction that is a small state-driven table, skip the provider function and the
explicit apply entirely:

```lua
local registrar = LibQuestieDB.GetRegistrar("MyAddon")

registrar.Set("Npc", "darkmoon-location", {
    [14828] = { [npcKeys.spawns] = { [215] = { {37.24, 37.67} } } },
})   -- visible immediately; no Apply() call

registrar.Set("Npc", "darkmoon-location", nil)   -- removes the slot; the layer underneath shows through
```

The long form is `LibQuestieDB.Corrections.Set(owner, datatype, name, rows)`, also aliased as
`LibQuestieDB.SetCorrection`.

* Each `(owner, datatype, name)` is a **slot**. Writing it again replaces the previous rows;
  `nil` removes the slot; `{}` keeps the slot but contributes nothing.
* There is no `loadOrder`: within an owner, slots take effect in creation order. Owner
  precedence is unchanged — the owner's rank is fixed by its first write or apply.
* Recomposition is scoped to the written datatype: an Item write does not drop Quest, Npc, or
  Object read caches, shared ID maps, or Name indexes.
* A name already registered as a function-shaped correction is refused — update that
  correction's captured state and re-apply instead.
* Function-shaped registration remains the right form for large tables: held behind a
  function, a multi-megabyte literal materialises only on apply. Function results are
  memoized per entry and re-run only by their own owner's apply, so another owner's `Set`
  never re-materialises them.
* The provider keeps `rows` **by reference** until the slot is rewritten or removed. Hand over
  a table you only ever mutate through another `Set`: the accumulate-and-rewrite pattern
  (mutate your table, `Set` it again) is exactly right, while mutating it without a `Set`
  leaves the published view stale until some other write to the same datatype flushes.

### Locale-first translatable fields

Entity Corrections supply English values. For a translatable field and a locale other than
`enUS`, localization resolves first:

1. the winning Dynamic Translation Correction for that locale;
2. the active Base translation, with Static Translation Corrections already folded in;
3. the corrected entity value;
4. the base entity value.

`enUS` skips the first two layers. A missing non-English translation falls through to normal
entity resolution. The winning English Correction is used when present; an explicit field
deletion remains authoritative; otherwise the read reaches base data. Fields that are not
translatable never enter localization. This keeps values such as `requiredRaces`
entirely under normal entity Correction precedence. See [ADR 0013](./adr/0013-locale-first-translatable-fields.md).

### Who won

```lua
LibQuestieDB.GetProvenance("Quest", 2, "name")
    --> active Dynamic Translation Correction owner, "QuestieDB" for a Base translation,
    --> otherwise the winning entity Correction owner

LibQuestieDB.l10n.GetProvenance("Quest", 2, "name")
    --> active translation owner, or nil when the entity layers supplied the value

LibQuestieDB.Corrections.GetProvenance("Quest", 2, "name")
    --> winning entity Correction owner, without localization

LibQuestieDB.GetOwners()                         --> entity Correction owners only
LibQuestieDB.Corrections.debug = true            --> logs entity-owner collisions
```

---

## Localization

```lua
LibQuestieDB.l10n.SetLocale("deDE")
QuestDB.name(2)                       --> "Klaue von Scharfkralle"
LibQuestieDB.l10n.SetLocale("enUS")
QuestDB.name(2)                       --> "Sharptalon's Claw"

LibQuestieDB.l10n.currentLocale
LibQuestieDB.l10n.IsAvailable()       --> whether this artifact contains Base translations
LibQuestieDB.l10n.onLocaleChanged[#… + 1] = function(locale) … end
```

Nine locales have generated Base translations: `deDE esES esMX frFR koKR ptBR ruRU zhCN
zhTW`. `enUS` bypasses localization because entity data is already English. In Baked mode,
selecting one of those nine locales decodes its four compressed Localization blocks. A custom
locale has no generated block or `localeIndex` entry, but `SetLocale(customLocale)` activates
Dynamic Translation Corrections registered for that exact string. Missing translated fields,
including every field in a custom locale with no registered slot, fall through to the normal
corrected entity value. Changing locale replaces the active Base blocks atomically and invalidates
cached entity values and Name indexes. Selecting the active locale is a no-op.

`l10n.IsAvailable()` reports only whether the artifact contains generated Base translation
blocks. It is false in Source mode, where ordinary Base translations remain unavailable.
Dynamic Translation Corrections work in either mode and do not change that result.

A translated `objectivesText` remains a table; element counts follow the upstream lookup and
may differ where a locale combines objectives. Every read returns a fresh mutable copy.

Translated fields: Quest `name` and `objectivesText`, Npc `name` and `subName`, Item `name`,
and Object `name`. Fields such as `requiredRaces` are not localized.

### Dynamic Translation Corrections

Use a Dynamic Translation Correction for non-English entity text that cannot be folded into a
Baked Localization block, or that depends on runtime facts owned by the publisher:

```lua
local questKeys = LibQuestieDB.Meta.QuestMeta.questKeys

LibQuestieDB.l10n.SetCorrection("MyAddon", "deDE", "Quest", "quest-text", {
    [2] = {
        [questKeys.name] = "Klaue von Scharfkralle",
        [questKeys.objectivesText] = { "Bringt die Klaue zu Senani Donnerherz." },
    },
})

LibQuestieDB.l10n.SetCorrection("MyAddon", "deDE", "Quest", "quest-text", nil)
```

Rows use **entity field indexes** from `LibQuestieDB.Meta`, not compact Localization-block
column indexes. Only the translated fields listed above are accepted. Scalar values are
non-empty strings; `objectivesText` is a non-empty dense string array. The locale may be one of
the nine generated locales or a custom locale. `SetCorrection` accepts any non-empty locale string
except `enUS`; registering a custom locale does not add it to `locales` or `localeIndex`.

Each `(owner, locale, datatype, name)` identifies one slot. A write snapshots its rows and
publishes immediately; `nil` withdraws the slot; `{}` keeps an empty slot. Owners and slots keep
their first successful write order, separately from entity Correction ordering, so refreshing
or withdrawing a slot cannot hoist it above a later publisher. A write for the active locale
invalidates only that entity type. Writes for inactive locales leave current caches alone, and
`SetLocale` selects the already-composed rows without reapplying entity Corrections.

Translation rows cannot create entities. They apply only while the entity exists in the
composed entity database, including an entity added by a normal Dynamic Correction.

QuestieDB uses this interface for Titan Reforged's 14 zhCN Quest rows. That set registers only
when the addon loads for Wrath season 109. Other flavors and seasons do not register it; changing
locale selects or hides it without changing the English Titan entity Corrections.

`extraObjectives` descriptions are different. Correction files author row slot `[3]` as an enUS
localization key, and QuestieDB preserves that English string. The entity localization overlay
does not translate structured `extraObjectives` rows. Consumers must translate that description
at render time with their own string-keyed localization function.

---

## Support data

Game reference data consumed as whole tables rather than through the metadata store.

```lua
LibQuestieDB.Support.Get("ZoneDB").zoneIDs
LibQuestieDB.Support.Get("ZoneDB").private.areaIdToUiMapId   -- a string; loadstring it
LibQuestieDB.Support.Get("QuestXP").db
LibQuestieDB.Support.Get("DropDB")
LibQuestieDB.Support.Get("QuestieDB").factionTemplate
```

The modules that wrap this data, including zone lookup, XP calculation, and drop resolution,
stay with the consumer. Only the data ships from here.

`Support.Get` and `Support.GetAll` expose the module set selected by the active flavor in both
Source and Baked mode. Source mode uses native per-file game-type conditions to select applicable
files from the shared base TOC before Lua executes. Baked TOCs list only applicable files.
Loading another flavor in the emulator replaces the published modules rather than retaining
modules from inapplicable variant files.

Mists uses its own area/UI map tables. Its drop data intentionally combines the MoP table and
then the Cata table, in the same effective order as Questie.

Forever owns its support inputs. Some map entries are retained solely for consumer instance
routing compatibility, not as evidence that their UiMaps exist in the Forever client. See the
[map audit](forever-map-override-audit.md) before using the mappings as an active-map allowlist.

Some zone maps and drop tables remain Lua source strings because the consumer's existing logic
calls `loadstring` on them. Their public type is part of the contract. Other fields, including
`QuestXP.db` and faction templates, are ordinary tables. Dungeon entries use this positional
shape:

```lua
{
    name,                         -- string
    alternativeAreaIds,           -- dense AreaId[] or nil
    parentZone,                    -- AreaId
    dungeonLocations,             -- { { areaId, x, y }, ... }
}
```

See [`support-data.md`](./support-data.md) for flavor selection and copied-data maintenance.

---

## Era-to-Forever coordinates

For consumer-owned Era points, such as Darkmoon Faire spawns or dungeon entrances:

```lua
local x, y = LibQuestieDB.EraToForever(215, 44.18, 76.06)             -- AreaID: Mulgore
local x, y = LibQuestieDB.EraToForeverByUiMapId(1412, 44.18, 76.06)   -- UiMapID: Mulgore
-- Both return approximately 43.888926, 76.659548.
```

Both functions take and return **0-100 percentages**, not normalized 0-1 coordinates.
They retain full precision without rounding or clamping. `-1, -1` instance-presence sentinels
pass through; a partial sentinel such as `-1, 20` raises an error. `0, 0` is a real point.

Only these four zone frames transform; every other ID passes through unchanged:

| Zone | AreaID | UiMapID |
| --- | ---: | ---: |
| Mulgore | 215 | 1412 |
| Eastern Plaguelands | 139 | 1423 |
| Redridge Mountains | 44 | 1433 |
| Stormwind City | 1519 | 1453 |

Pass the ID of the map on which the **input point is expressed**. For a dungeon entrance,
use its outdoor zone, not the dungeon's ID. The helpers do not infer parent frames from
subzone IDs. Unknown IDs also pass through; this does not verify their compatibility.

The helper is generated from DBC bounds, currently Era `1.15.9.69722` to Forever
`1.60.1.69893`. Its header records the builds. The offline DBC commands always check its
behavior; maintainers can [regenerate it explicitly](../tools/dbc/README.md#generated-runtime-helper-and-mandatory-check).
The projection assumes the landmark's world position did not move. No DBC access or WoW map
APIs are needed at runtime.

These are explicit, dot-called helpers available in both Source and Baked modes on every
flavor. The caller decides when Forever output is wanted. They do not modify data or run
automatically during reads. **Do not apply them to already-converted Forever coordinates.**
Older QuestieDB releases may lack these additive helpers; check for the function before use
when supporting those releases.

---

## Read mode

```lua
LibQuestieDB.readMode                   --> "source" | "baked"
LibQuestieDB.ModeIndicator.GetText()    --> "QuestieDB: SOURCE MODE (Classic)" or nil
LibQuestieDB.ModeIndicator.GetStatus()  --> { mode =, expansion =, contractVersion = }
```

**Source mode** reads from raw entity data with Static Corrections applied live — a working
development environment from a clone on clients supporting native per-file game-type
selection, with no download and no Lua toolchain. **Baked mode**
reads from a generated TOC metadata store. The client picks by TOC suffix precedence, so a
generated artifact wins simply by existing.

Forever uses the same public API and LuaLS declarations. Its independent inputs and pending
client acceptance are described in [Forever](forever.md). Interface metadata alone does not
prove native Source selection support; there is no Lua fallback for older clients.

A consumer should surface source mode somewhere permanent. QuestieDB draws its own small
indicator as a fallback, but a consumer's own settings panel or map is the better home.

---

## Contract version

Independent release cycles make skew inevitable.

```lua
local ok, message = LibQuestieDB.RequireContract(1)
if not ok then
    print(message)
    return
end
```

`LibQuestieDB.contractVersion` and `LibQuestieDB.minSupportedContract` expose the current
contract and oldest supported consumer contract directly. Both are positive integers;
the shared runtime/generator configuration rejects invalid or inverted ranges.
Contract 2 introduces CBOR scalar
rows, CBOR table values, compressed CBOR ID headers, and compressed locale-and-type
localization columns. These storage changes ship together and do not change the public read
API, so `minSupportedContract` remains 1.

The check is a **range**: `RequireContract(v)` passes for any
`minSupportedContract <= v <= contractVersion`, so a consumer built against an older
contract keeps working across additive releases. Requirements must be positive integers;
fractional numbers, numeric strings, missing values, NaN, and infinity are rejected.
The floor rises only when a breaking change genuinely abandons older consumers.

Published `release.json` manifests include `questiedb.version`, `questiedb.contractVersion`, and
`questiedb.minSupportedContract`. `version` is the actual packaged TOC version, including the
`-dev.<commit>` suffix for previews. Packaging verifies that all selected flavors agree
on their version and that their contract matches the shipped runtime configuration.
Consumers selecting published releases must check the complete supported range, not
just whether the provider's current contract is greater than their requirement. Root `releases`
entries describe addon-manager downloads; `questiedb.artifacts` retains provider ZIP checksums
and sizes. See the [release manifest format](../tools/distribution/README.md#release-manifest)
for provenance, changelog, and combined-release consumption.

---

## Cache

```lua
LibQuestieDB.InvalidateCache("Quest", 2)   -- one entity
LibQuestieDB.InvalidateCache("Quest")      -- one type ("quest" works too)
LibQuestieDB.InvalidateCache()             -- everything
```

Applying corrections and changing locale already invalidate what they need to, the Name index
included. Correction writes are scoped to their datatypes; a locale change covers all four.
This API is for a consumer that mutates state QuestieDB cannot see. Every form drops the Name
index, including per-entity invalidation, because one entity's name can change.

In Baked mode, the first read of a known entity decodes its CBOR scalar row and adopts that
table as the cache row. Corrections and active scalar translations settle before the row is
installed. Table fields cache producers over decoded CBOR bytes, not decoded tables, so each
read still returns a fresh value. Presence-mask misses cache their nil or never-nil default
without a metadata call. Unknown IDs create no cache entry.
