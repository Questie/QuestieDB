## Title: C_QuestLog.IsQuestFlaggedCompleted

**Content:**
Returns if a quest has been completed.
`isCompleted = C_QuestLog.IsQuestFlaggedCompleted(questID)`

**Parameters:**
- `questID`
  - *number*

**Returns:**
- `isCompleted`
  - *boolean* - Returns true if completed; returns false if not completed or if the questID is invalid.

**Usage:**
Returns if WANTED: "Hogger" has been completed.
`/dump C_QuestLog.IsQuestFlaggedCompleted(176)`

**Reference:**
- `C_QuestLog.GetAllCompletedQuestIDs()`