## Title: GetQuestLogLeaderBoard

**Content:**
Returns info for a quest objective in the quest log.
`description, objectiveType, isCompleted = GetQuestLogLeaderBoard(i, questIndex)`

**Parameters:**
- `i`
  - *number* - Index of the quest objective to query, ascending from 1 to GetNumQuestLeaderBoards(questIndex).
- `questIndex`
  - *Optional Number* - Index of the quest log entry to query, ascending from 1 to GetNumQuestLogEntries. If not provided or invalid, defaults to the currently selected quest (via SelectQuestLogEntry).

**Returns:**
- `description`
  - *string* - Text description of the objective, e.g. "0/3 Monsters slain"
- `objectiveType`
  - *string* - A token describing objective type, one of "item", "object", "monster", "reputation", "log", "event", "player", or "progressbar".
- `isCompleted`
  - *boolean* - true if sub-objective is completed, false otherwise

**Usage:**
The following function attempts to parse the description message to figure out exact progress towards the objective:
```lua
function GetLeaderBoardDetails(boardIndex, questIndex)
  local description, objectiveType, isCompleted = GetQuestLogLeaderBoard(boardIndex, questIndex)
  local itemName, numItems, numNeeded = description:match("(.*):%s*(%d+)%s*/%s*(%d+)")
  return objectiveType, itemName, numItems, numNeeded, isCompleted
end
-- returns eg. "monster", "Young Nightsaber slain", 1, 7, nil
```

**Description:**
- The type "player" was added in WotLK, which is used by No Mercy! and probably other quests.
- The type "log" was added sometime around patch 3.3.0, and seems to have replaced many instances of "event".
- Only ever found one quest, The Thandol Span that had an "object" objective.
- The description return value can be incomplete under some circumstances, with localized item or NPC names missing from the text.

**Reference:**
- `GetQuestObjectiveInfo` - A function with identical returns, but takes a QuestID argument instead of QuestLogIndex.