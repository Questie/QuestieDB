## Title: GetNumQuestLeaderBoards

**Content:**
Returns the number of objectives for a quest.
`numQuestLogLeaderBoards = GetNumQuestLeaderBoards()`

**Parameters:**
- `questID`
  - *number* - Identifier of the quest. If not provided, defaults to the currently selected Quest, via `SelectQuestLogEntry()`.

**Returns:**
- `numQuestLogLeaderBoards`
  - *number* - The number of objectives this quest possesses (Can be 0).

**Description:**
Previous versions of this page stated that the function returns three values, but did not list what the other two values were.