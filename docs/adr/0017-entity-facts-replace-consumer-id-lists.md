# 17. Entity facts replace consumer ID lists

Date: 2026-11-24. Status: accepted.

## Context

Questie classifies entities with hardcoded ID lists that live far from the entities they describe:

- Townsfolk lists repeat a full copy per expansion: mailboxes (388 unique objects), class trainers
  (735 NPCs), 16 profession trainer files (about 874 NPCs), meeting stones (77), profession stations,
  weapon masters and an inline portal trainer list.
- `npcFlags` is a bitmask whose bit values change between expansions (VENDOR is 4 in Classic and 128
  from TBC). It cannot say which class or skill a trainer teaches.
- Objects carry no classification. Mailbox faction is derived at login from `factionID` and the
  faction template support tables with bit tests. Only mailbox objects carry a `factionID`, and
  Forever's 65 mailboxes carry none.
- Event membership is a Questie list of 1002 quests keyed by English event names. Gating works by
  copying 979 of those quests into the quest blacklist by hand and removing active ones at login.

The lists drift: Forever has no mailbox list, battle pet trainers are matched by English subname,
and three SoD Winter Veil quests are never hidden outside the event.

## Decisions

### 1. Membership is an entity fact; selection stays with the consumer

QuestieDB stores what an entity is and which conditions it belongs to. The consumer decides which
conditions are active and what to show. This extends ADR 0007 D1 rather than changing it: event
activity is consumer-owned runtime state, and it changes within a session (ADR 0009 D3).

Blacklists, content phases and expansion gates are out of scope and stay consumer policy
(DESIGN.md "What stays in Questie").

### 2. Classification values are lists of enum IDs, not masks

New classification fields store lists of small enum IDs. Adding a member never requires a free
bit, and the `_add`/`_remove` Correction operations from ADR 0016 apply unchanged. Enum values are
sequential and identical across expansions, published like `raceKeys`.

### 3. `services` on NPCs and objects

`services` is a list field on Npc and Object, keyed by one shared `Enum.serviceKeys`. The enum
covers every `npcFlags` meaning (vendor, repair, banker, innkeeper, flight master and so on),
trainer kinds (class, profession, weapon master, portal, pet, demon, battle pet) and object kinds
(mailbox, meeting stone, anvil, forge, alchemy lab, moonwell).

Values are converted once from `npcFlags` and Questie's lists, then authored directly.
`npcFlags` stays readable for existing consumers: a Derived Pass rebuilds it from `services` with
each expansion's bit values, so authors edit only `services`.

### 4. Trainer detail

- `trainerClass`: the class ID a class trainer teaches.
- `trainerSkills`: a list of skill line IDs for profession, weapon and riding trainers. Weapon
  masters teach several skills, hence a list.

### 5. Object faction availability

Objects gain `requiredFaction`: `"A"` for Alliance only, `"H"` for Horde only. A missing value
means no restriction, so objects usable by both factions store nothing. Like `requiredRaces` and
`requiredClasses` on quests, the field only records a restriction.

Objects do not reuse the NPC field `friendlyToFaction`, where a missing value means friendly to
neither faction. One name with opposite nil meanings would break shared consumer checks.

`requiredFaction` is converted once from `factionID` and the faction template tables: hostile to
Horde gives `"A"`, hostile to Alliance gives `"H"`, anything else stores nothing. Templates
missing from a table and Forever mailboxes are resolved by hand. The faction template support
tables are then removed; nothing else reads them.

Object `factionID` remains a promised name. It becomes a deprecated constant `0` through
`constantValues`, as the NPC health fields did. Reads on every path (`Get`, `GetByIndex`, `GetRaw`,
`GetAll`, named getter) print a deprecation message once per calling addon per session; the caller
is found by walking `debugstack()` for the first addon folder that is not QuestieDB's.
`minSupportedContract` does not change.

### 6. `eventIds` on quests and NPCs

`eventIds` is a list of signed event IDs:

- A positive ID means the entity is available only while that event is active. With several
  positive IDs, any one active event is enough.
- A negative ID means the entity is unavailable while that event is active.

Event IDs come from two sources:

- Blizzard Holidays IDs, used as-is where a Holidays row exists (for example Hallow's End 324).
  Darkmoon Faire has one Holidays ID per location, which expresses location-dependent quests.
- QuestieDB-defined IDs from 100000 upward for events without a Holidays row, such as the
  Ahn'Qiraj war effort and the Scourge invasion.

QuestSort IDs are not event IDs. They are quest-log categories, already stored in `zoneOrSort`,
and they collide with Holidays IDs (404 is Winter Veil as a QuestSort and Pilgrim's Bounty as a
Holidays ID).

### 7. One field per condition kind

Each condition kind gets its own field with its own ID space and the rule from Decision 6. A later
kind, such as phases, is a new field. An entity is available when every condition field passes.
The Presence mask caps a schema at 52 fields, which leaves room for the expected few kinds.

### 8. Query helpers

- `LibQuestieDB.Set(...)` builds a lookup set `{[id] = true}` from IDs.
- `NpcDB.HasServices(id, wanted)` and `ObjectDB.HasServices(id, wanted)` return whether the entity
  has any service in `wanted`.
- `Entity.HasAny(id, field, set)` answers the same question for any list field.
- `NpcDB.GetServices(id)` and `ObjectDB.GetServices(id)` return the entity's services as a lookup
  set, or `nil` when it has none, matching how empty list fields read.

`HasServices` and `HasAny` read QuestieDB's internal cached value and return a boolean, so they
allocate nothing per call; use them when scanning many entities. `GetServices` returns a fresh
Caller-owned set on every call. The named getter `services(id)` still returns the stored list.

### 9. Contract

New fields and helpers are added under contract 5. Nothing is removed.

## Consequences

- Questie deletes its townsfolk ID lists, `GetFactionSpecificMailboxes`, the event quest lists,
  the 979 duplicated blacklist entries and the event NPC list. Event dates, Darkmoon Faire
  scheduling, partial-event windows and `hideFlag` expansion gates stay in Questie.
- Per-expansion copies disappear because each flavor's data carries its own values.
- Townsfolk still scans entities at login. A reverse index (`IdsByField`) is an experiment to
  measure, not part of this decision.

## Open questions

- Confirm Holidays IDs are the same in Classic Era, Cata and MoP clients. Only the Wotlk export
  has been checked. Cata may add an ID for Darkmoon Island.
- Map Holidays IDs to names from a `HolidayNames` export, including which Darkmoon Faire ID
  (374, 375, 376) is which location.
- Decide whether `eventIds` is needed on objects.
