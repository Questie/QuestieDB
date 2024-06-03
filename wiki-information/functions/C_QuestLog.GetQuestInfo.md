## Title: C_QuestLog.GetQuestInfo

**Content:**
Returns the name for a Quest ID.
`title = C_QuestLog.GetQuestInfo(questID)`

**Parameters:**
- `questID`
  - *number*

**Returns:**
- `title`
  - *string* - name of the quest

**Description:**
This API does not require the quest to be in your quest log.
If the name is still an empty string (after having queried it from the server once) then the quest is assumed to have been removed.

**Reference:**
QuestEventListener