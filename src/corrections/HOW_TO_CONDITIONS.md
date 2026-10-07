# How to write quest conditions

A condition decides when a quest is available. Use one when the normal quest fields
(`preQuestSingle`, `exclusiveTo`, `requiredRaces`, ...) can't express the rule, for example
"only while the player has a buff".

Conditions are written in the normal quest correction files, next to the quest's other fixes.

## The basics

1. At the top of the correction file, next to the other imports, add:

   ```lua
   local C = QuestieLoader:ImportModule("ConditionBuilder")
   ```

2. In the quest's correction, set `questKeys.conditions`:

   ```lua
   [1318] = { -- Unfinished Gordok Business
       [questKeys.conditions] = C.HasAura(22799), -- King of the Gordok
   },
   ```

That's it. The quest is available while the condition is true. Questie still applies all the
quest's other fields as well.

A mistake, such as a misspelled function or a wrong argument, stops the file from loading with an
error that names the problem. Run `lua5.1 test.lua conditions` to check every condition.

## Example: disabled by more than one quest

`disabledByQuest` takes a single quest: the quest is hidden while that quest is in the quest log.
To hide it while either of two quests is in the log, write a condition instead:

```lua
[1234] = {
    -- Hidden while quest 1111 or 2222 is in the quest log
    [questKeys.conditions] = C.Not(
      C.Any(
        C.QuestInLog(1111),
        C.QuestInLog(2222)
      )
    ),
},
```

Read it as "not if any of these is in the quest log". Add more `C.QuestInLog(...)` inside the
`C.Any(...)` for more quests. Don't use `C.Not(C.All(...))` here: that hides the quest only
while *all* of them are in the log at the same time.

If the quest already has a `disabledByQuest`, either keep it and list only the other quests here,
or remove it and list all of them here. A quest has one condition, so if it already has one, put
both inside one `C.All(...)`.

## Combining conditions

| Write | Meaning |
| --- | --- |
| `C.All(a, b, ...)` | Every condition must be true |
| `C.Any(a, b, ...)` | At least one condition must be true |
| `C.Not(a)` | The condition must be false |

They can be nested:

```lua
-- Alliance, and either quest 100 is turned in or quest 101 is in the quest log
[questKeys.conditions] = C.All(
    C.IsTeam("Alliance"),
    C.Any(C.QuestRewarded(100), C.QuestInLog(101))
),
```

`All` and `Any` need at least two conditions.

## All functions

Quest IDs, item IDs, and spell IDs in these examples are placeholders, except Gordok's aura.

### Quests

| Function | True when | Example |
| --- | --- | --- |
| `QuestRewarded(questId)` | The quest is turned in | `C.QuestRewarded(1517)` |
| `QuestInLog(questId)` | The quest is in the quest log | `C.QuestInLog(1190)` |
| `QuestComplete(questId)` | The quest is in the log with its objectives done | `C.QuestComplete(11296)` |
| `QuestNone(questId)` | The quest is neither in the log nor turned in | `C.QuestNone(1642)` |
| `QuestAvailable(questId)` | The player could accept that quest now | `C.QuestAvailable(1194)` |

### Auras, items, and spells

| Function | True when | Example |
| --- | --- | --- |
| `HasAura(spellId)` | The player has the buff or debuff | `C.HasAura(22799)` |
| `HasItem(itemId[, count])` | The bags hold the item, at least `count` (default 1) | `C.HasItem(7667)`, `C.HasItem(5, 10)` |
| `HasItemOrBank(itemId[, count])` | Like `HasItem`, also counting the bank | `C.HasItemOrBank(7667)` |
| `HasItemEquipped(itemId)` | The item is equipped | `C.HasItemEquipped(12345)` |
| `KnowsSpell(spellId)` | The player has learned the spell | `C.KnowsSpell(12345)` |
| `HasAchievement(achievementId)` | The achievement is earned (always true on clients without achievements) | `C.HasAchievement(416)` |

### Professions and reputation

| Function | True when | Example |
| --- | --- | --- |
| `HasSkill(skillId[, level])` | The profession is at least `level` (default 1) | `C.HasSkill(profKeys.ALCHEMY, 150)` |
| `HasRep(factionId, rank)` | Reputation is at least `rank` | `C.HasRep(factionIDs.THE_ORACLES, C.standing.HONORED)` |
| `RepBelow(factionId, rank)` | Reputation is at most `rank` | `C.RepBelow(factionIDs.THE_ORACLES, C.standing.NEUTRAL)` |

Always write ranks with `C.standing`: `HATED`, `HOSTILE`, `UNFRIENDLY`, `NEUTRAL`, `FRIENDLY`,
`HONORED`, `REVERED`, `EXALTED`. Plain numbers are easy to get wrong by one.

### Character

| Function | True when | Example |
| --- | --- | --- |
| `IsTeam(faction)` | The player is `"Alliance"`, `"Horde"`, or `"Neutral"` | `C.IsTeam("Horde")` |
| `IsRace(races)` | The player's race is in the list | `C.IsRace(raceIDs.HUMAN + raceIDs.DWARF)` |
| `IsClass(classes)` | The player's class is in the list | `C.IsClass(classIDs.PALADIN)` |
| `IsRaceClass(races, classes)` | Both of the above | `C.IsRaceClass(raceIDs.HUMAN, classIDs.MAGE)` |
| `IsLevel(level)` | The player is at least this level | `C.IsLevel(30)` |
| `IsLevelExact(level)` | The player is exactly this level | `C.IsLevelExact(60)` |
| `IsLevelBelow(level)` | The player is at most this level | `C.IsLevelBelow(48)` |

Combine races or classes with `+`, as in other corrections.

### Not available yet

Server events, holidays, and world states can't be used in conditions yet. Questie can't check
them, so the builder rejects them.

## Rules

- **Write races and classes with `raceIDs` / `classIDs`, never as numbers.** The names adapt to
  each game version; on Forever, `raceIDs.ALL_ALLIANCE` includes Skyborne. A plain number like
  `77` doesn't, and the test rejects it on Forever.
- **For a whole faction, `C.IsTeam("Alliance")` is simplest**, but
  `C.IsRace(raceIDs.ALL_ALLIANCE)` also works.
- **Don't let two quests require each other with `QuestAvailable`.** The test rejects such cycles.
- **Prefer the normal quest fields** when they can express the rule. A condition is for what
  they can't express.
