## Title: GetQuestLink

**Content:**
Returns a QuestLink for a quest.
`questLink = GetQuestLink(questID)`

**Parameters:**
- `questID`
  - *number* - Unique identifier for a quest.

**Returns:**
- `QuestLink`
  - *string* - The link to the quest specified
  - or `nil`, if the QuestID is invalid. `nil` is also returned if the specified QuestID is not currently in the player's quest log.