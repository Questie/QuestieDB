## Title: GetAbandonQuestName

**Content:**
Returns the name of a quest that will be abandoned if `AbandonQuest` is called.
`questName = GetAbandonQuestName()`

**Returns:**
- `questName`
  - *string* - Name of the quest that will be abandoned.

**Description:**
The FrameXML-provided quest log calls `SetAbandonQuest` whenever a quest entry is selected, so this function will usually return the name of the currently selected quest.

**Reference:**
- `SetAbandonQuest`
- `AbandonQuest`