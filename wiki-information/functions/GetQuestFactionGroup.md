## Title: GetQuestFactionGroup

**Content:**
`factionGroup = GetQuestFactionGroup(questID)`

**Parameters:**
- `questID`
  - *number* - Unique QuestID.

**Returns:**
- `factionGroup`
  - *number*
    - **Key** | **Value** | **Description**
    - --- | --- | ---
    - 0 | Neutral | LE_QUEST_FACTION_ALLIANCE
    - 1 | Alliance | LE_QUEST_FACTION_HORDE
    - 2 | Horde | 

**Reference:**
QuestMapFrame.lua, patch 6.0.2