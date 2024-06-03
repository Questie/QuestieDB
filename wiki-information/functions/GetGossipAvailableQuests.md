## Title: GetGossipAvailableQuests

**Content:**
Returns a list of available quests from a gossip NPC. For getting the number of available quests from a non-gossip NPC see `GetNumAvailableQuests`.
```lua
title1, level1, isTrivial1, frequency1, isRepeatable1, isLegendary1, isIgnored1, title2, ... = GetGossipAvailableQuests()
```

**Returns:**
The following seven return values are provided for each quest offered by the NPC:
- `title`
  - *string* - The name of the quest.
- `level`
  - *number* - The level of the quest.
- `isTrivial`
  - *boolean* - true if the quest is trivial (too low-level compared to the character), false otherwise.
- `frequency`
  - *number* - 1 if the quest is a normal quest, `LE_QUEST_FREQUENCY_DAILY` (2) for daily quests, `LE_QUEST_FREQUENCY_WEEKLY` (3) for weekly quests.
- `isRepeatable`
  - *boolean* - true if the quest is repeatable, false otherwise.
- `isLegendary`
  - *boolean* - true if the quest is a legendary quest, false otherwise.
- `isIgnored`
  - *boolean* - true if the quest has been ignored, false otherwise.

**Description:**
Available quests are quests that the player does not yet have in their quest log.
This list is available after `GOSSIP_SHOW` has fired.

**Reference:**
- `GetGossipActiveQuests`
- `GetNumAvailableQuests`
- `GetNumActiveQuests`