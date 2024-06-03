## Title: IsQuestComplete

**Content:**
Returns whether the supplied quest in the quest log is complete.
`isComplete = IsQuestComplete(questID)`

**Parameters:**
- `questID`
  - *number* - The ID of the quest.

**Returns:**
- `isComplete`
  - *boolean* - true if the quest is both in the quest log and is complete, false otherwise.

**Description:**
This function will only return true if the questID corresponds to a quest in the player's log. If the player has already completed the quest, this will return false.
This can return true even when the "isComplete" return of `GetQuestLogTitle` returns false, if the quest in question has no objectives to complete.

**Reference:**
- `GetQuestLogTitle`
- `IsQuestFlaggedCompleted`