## Title: GetGossipActiveQuests

**Content:**
Returns a list of active quests from a gossip NPC. For getting the number of active quests from a non-gossip NPC see `GetNumActiveQuests`.
```lua
title1, level1, isLowLevel1, isComplete1, isLegendary1, isIgnored1, title2, ... = GetGossipActiveQuests()
```

**Returns:**
The following six return values are provided for each active quest:
- `title`
  - *string* - The name of the quest
- `level`
  - *number* - The level of the quest
- `isLowLevel`
  - *boolean* - true if the quest is low level, false otherwise
- `isComplete`
  - *boolean* - true if the quest is complete, false otherwise
- `isLegendary`
  - *boolean* - true if the quest is a legendary quest, false otherwise
- `isIgnored`
  - *boolean* - true if the quest has been ignored, false otherwise

**Description:**
The active quests for an NPC are available after `GOSSIP_SHOW` has fired.

**Reference:**
- `GetGossipAvailableQuests`
- `GetNumAvailableQuests`
- `GetNumActiveQuests`