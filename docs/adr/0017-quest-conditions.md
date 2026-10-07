# 17. Quest Conditions: provider-owned expressions and evaluator

Date: 2026-10-07. Status: accepted.

## Context

Server emulators gate quest availability with condition tables: "quest A is rewarded and quest
B is not", "the player has aura X", "reputation with faction Y is at least Honored". Questie's
quest fields cover the common cases (`preQuestSingle`, `exclusiveTo`, `requiredMinRep`, ...),
but not arbitrary combinations. Converted condition tables exist for Classic, TBC, and WotLK.

The data is entity data, so it belongs to QuestieDB (Questie ADR 0001). The evaluator could
live in either project. If it lives in Questie, other consumers can read expressions they
cannot evaluate, and the vocabulary the data uses is defined in a different repository from
the data itself.

## Decisions

### 1. Expressions are a Quest field

`conditions` (field 37) holds a Lua boolean expression over a fixed vocabulary, such as
`"QuestRewarded(1517) and not QuestRewarded(1518)"`. Only Quest has the field; no other entity
has condition data. A trailing field can be added to another entity later without migrating
existing rows.

The converted tables ship as generated Static Corrections, one file per expansion. Each table
was converted from that expansion's server data, so none is inherited by later legacy flavors.
Forever inherits the Era table through its owned converted copy, like the other Era Corrections.
The tables load after other generated data in their window and before authored fixes, which may
override them.

### 2. QuestieDB owns the vocabulary and the evaluator

`src/conditions.lua` defines every condition function using client APIs only, so any addon can
evaluate conditions without Questie. Functions that need state the client cannot provide
(`QuestAvailable`, `HasSkill`, `EventActive`, `HolidayActive`, `WorldState`) are permissive
stubs that return true. Unknown function names are also permissive. A negated stub
(`not EventActive(12)`) is therefore false and would hide its quest for every consumer, so the
data validation rejects negated stubs.

Expressions compile once per distinct string. `Evaluate(expression)` is the primitive;
`EvaluateQuest(questId)` reads the field and evaluates it.

### 3. One trusted owner publishes shared functions

Questie has better answers for some functions: its own quest-state caches, its availability
rules, and its profession mapping. `SetFunctions(owner, functions)` publishes overrides and new
names into the single environment every consumer evaluates against. A write copies the table
and replaces the previous set; `nil` withdraws it.

Only Questie may publish. Other consumers benefit from Questie's versions, but their variants
must not change what Questie shows, and two consumers overriding the same name would make
results depend on load order. A consumer that needs private variants can be given a derived
environment when one exists; none does yet.

### 4. Unreadable state is unknown, not false

Clients with secret values can withhold aura data, which `C_Secrets.ShouldAurasBeSecret()`
reports; without that query, QuestieDB assumes auras are hidden in combat. Treating hidden data
as "no aura" would hide quests during combat and show them again afterwards, or show quests a
negated check should hide.

A condition function returns nil when it cannot read its state. Any nil reached during an
evaluation makes the result nil, regardless of `and`, `or`, and `not`. The caller keeps its
previous answer and evaluates again later. Lua's three-valued logic is not reproduced: one
flag per evaluation is simpler, and an over-cautious nil only delays an answer.

### 5. Failures are permissive and reported once

An expression that does not compile or raises an error evaluates to true. Each distinct error
message is reported once through the client's error handler, so one broken function used by many
expressions produces one report. Re-entering an expression that is already being evaluated
returns true. The same string always makes the same calls, so re-entry could never finish;
it happens when a published `QuestAvailable` evaluates the quest that asked about it. With a
cycle between quests, the answer would depend on which quest was evaluated first, so the data
validation rejects `QuestAvailable` cycles.

### 6. Correction files write expressions with a builder

Correction files build expressions with `ConditionBuilder` (`src/corrections/conditionBuilder.lua`)
instead of writing strings:

```lua
[questKeys.conditions] = C.All(C.IsTeam("Alliance"), C.Not(C.QuestRewarded(1518))),
```

Each call returns the canonical string the evaluator reads, so storage and evaluation are
unchanged. The builder raises an error when a file loads with an unknown function, a wrong
argument, or a string it did not produce, instead of the evaluator treating it as true at
runtime. Flavor enums such as `raceKeys` resolve when the file loads, as for other fields.

Faction-wide checks use `IsTeam` with the tag `UnitFactionGroup` returns (`"Alliance"`,
`"Horde"`, or `"Neutral"`). A race mask is a literal in the stored string, so it cannot follow
Forever adding Skyborne to Era's factions: an inherited `IsRace(77)` would exclude Skyborne
Alliance players. The data validation therefore rejects faction-wide `IsRace` masks and race
bits a flavor does not have. `IsRace` is for real race subsets.

Storing an expression tree instead was rejected. It needs a new field type and evaluator, and
the string already carries everything the evaluator needs. When a UI needs the structure, for
example to show which part of a condition fails, `Explain` parses the builder's grammar back into
a tree on demand.

## Consequences

QuestieDB reads player state for the first time. The reads are direct client calls with no
caching or event handling, so the provider still has no lifecycle of its own. Consumers decide
when to evaluate.

Contract 4 adds `LibQuestieDB.Conditions` and the Quest `conditions` field. Consumers that
evaluate conditions must require contract 4.
