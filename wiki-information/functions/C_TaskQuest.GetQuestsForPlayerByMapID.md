## Title: C_TaskQuest.GetQuestsForPlayerByMapID

**Content:**
Locates world quests, follower quests, and bonus objectives on a map.
`taskPOIs = C_TaskQuest.GetQuestsForPlayerByMapID(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `taskPOIs`
  - *TaskPOIData*
    - `Field`
    - `Type`
    - `Description`
    - `questId`
      - *number*
    - `x`
      - *number*
    - `y`
      - *number*
    - `inProgress`
      - *boolean*
    - `numObjectives`
      - *number*
    - `mapID`
      - *number*
    - `isQuestStart`
      - *boolean*
    - `isDaily`
      - *boolean*
    - `isCombatAllyQuest`
      - *boolean*
    - `childDepth`
      - *number?*

**Reference:**
- `C_QuestLine.GetAvailableQuestLines()`