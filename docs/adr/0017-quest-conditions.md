# 17. Quest Conditions: provider-owned expressions and evaluator

Date: 2026-10-07. Status: accepted.

## Context

Server emulators gate quest availability with condition tables: "quest A is rewarded and quest
B is not", "the player has aura X", "reputation with faction Y is at least Honored". Questie's
quest fields cover the common cases (`preQuestSingle`, `exclusiveTo`, `requiredMinRep`, ...),
but not arbitrary combinations, and Forever needs such rules for its own content.

The data is entity data, so it belongs to QuestieDB (Questie ADR 0001). The evaluator could
live in either project. If it lives in Questie, other consumers can read expressions they
cannot evaluate, and the vocabulary the data uses is defined in a different repository from
the data itself.

## Decisions

### 1. Expressions are a Quest field

`conditions` (field 37) holds a boolean expression over a fixed vocabulary, such as
`"QuestRewarded(1517) and not QuestRewarded(1518)"`. The grammar is what the builder emits:
calls with number or string arguments, `and`, `or`, `not`, and parentheses. Only Quest has the field; no other entity
has condition data. A trailing field can be added to another entity later without migrating
existing rows.

Conditions are ordinary correction values, written in the existing correction files next to a
quest's other fixes. There are no condition-specific files. Generated per-expansion tables
converted from server condition data were tried and removed: most of their rules duplicated
existing quest fields, and a separate file split a quest's availability rules across two places.
The first examples are authored Forever corrections, such as "Unfinished Gordok Business"
requiring the King of the Gordok aura.

### 2. QuestieDB owns the vocabulary and the evaluator

`src/conditions.lua` defines every condition function using client APIs only, so any addon can
evaluate conditions without Questie. Functions that need state the client cannot provide
(`QuestAvailable`, `HasSkill`) are permissive stubs that return true.

The data is written for Questie, which publishes real `QuestAvailable` and `HasSkill`, so
corrections may negate any function. A consumer without Questie gets the stubs, where a negated
stub is false; supplying better answers is that consumer's concern.

Expressions parse once per distinct string into a tree. `Evaluate(expression)` walks it and
stops at the operand that decides the result; `Explain(expression)` evaluates every leaf for
display. Both combine operands with the same function, so they always agree.
`EvaluateQuest(questId)` reads the field and evaluates it.

### 3. One trusted owner publishes shared functions

Questie has better answers for some functions: its own quest-state caches, its availability
rules, and its profession mapping. `SetFunctions(owner, functions)` publishes replacements for
base functions into the single environment every consumer evaluates against. Names outside the
vocabulary are rejected: the grammar only accepts vocabulary names, so no expression could call
them, and a misspelled override would otherwise be ignored silently. A write copies the table
and replaces the previous set; `nil` withdraws it.

Only Questie may publish. Other consumers benefit from Questie's versions, but their variants
must not change what Questie shows, and two consumers overriding the same name would make
results depend on load order. The owner name is a convention between cooperating addons, not
authentication: any addon can pass `"Questie"`. A consumer that needs private variants can be
given a derived environment when one exists; none does yet.

### 4. Unreadable state is unknown, not false

Clients with secret values can withhold aura data, which `C_Secrets.ShouldAurasBeSecret()`
reports; without that query, QuestieDB assumes auras are hidden in combat. Treating hidden data
as "no aura" would hide quests during combat and show them again afterwards, or show quests a
negated check should hide.

A condition function returns nil when it cannot read its state. `and`, `or`, and `not`
combine true, false, and nil with three-valued logic: a false operand decides `and`, a true
operand decides `or`, and otherwise any nil makes the result nil. The answer does not depend on
operand order. The caller keeps its previous answer for nil and evaluates again later.

An earlier version compiled expressions with `loadstring` and returned nil whenever any nil was
reached. Its answer depended on operand order (`HasAura(1) and QuestRewarded(2)` was nil where
the reverse was false), and it disagreed with `Explain`. One tree and one combine function
removed both problems.

### 5. Failures are permissive and reported once

An expression outside the grammar, including one that names an unknown function, evaluates
to true and is reported once. A condition function that raises an error makes the expression
true; each distinct error message is reported once through the client's error handler, so one
broken function used by many expressions produces one report. `Explain` returns nil for both. Re-entering an expression that is already being evaluated
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

`IsTeam` takes the tag `UnitFactionGroup` returns (`"Alliance"`, `"Horde"`, or `"Neutral"`).
Race masks are written with `raceKeys`, which resolve per flavor when the file loads, so
`IsRace(raceKeys.ALL_ALLIANCE)` includes Skyborne on Forever. A literal number does not
adapt: an `IsRace(77)` written for Era would exclude Skyborne Alliance players on Forever. The
data validation rejects race bits a flavor does not have, and Era's literal faction masks 77
and 178 on Forever.

Storing an expression tree instead was rejected. It needs a new field type, and the string
already carries everything the evaluator needs. The evaluator parses each distinct string once
and caches the tree, which `Explain` also uses to show which part of a condition fails.

### 7. Server state is a future improvement

`EventActive`, `HolidayActive`, and `WorldState` are not in the vocabulary, rather than offered
as always-true stubs. Questie cannot answer them yet, and a stub that is always true is wrong
whenever a condition negates it. The builder rejects them when a correction file loads. A raw
expression that names one is outside the grammar, so the whole expression is permissive and
reported once, as for any unknown name. `HolidayActive` is the likely first: Questie already
tracks active holidays in `QuestieEvent` and would need a holiday ID mapping. `EventActive`
uses server-emulator event IDs with no client equivalent, and the client only exposes world
states shown in UI widgets.

## Consequences

QuestieDB reads player state for the first time. The reads are direct client calls with no
caching or event handling, so the provider still has no lifecycle of its own. Consumers decide
when to evaluate.

Contract 4 adds `LibQuestieDB.Conditions` and the Quest `conditions` field. Consumers that
evaluate conditions must require contract 4.
