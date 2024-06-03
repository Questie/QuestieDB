## Title: C_TaskQuest.IsActive

**Content:**
Needs summary.
`active = C_TaskQuest.IsActive(questID)`

**Parameters:**
- `questID`
  - *number*

**Returns:**
- `active`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific task quest is currently active. For instance, an addon that tracks world quests might use this function to determine if a particular world quest is available for the player.

**Addon Usage:**
Large addons like World Quest Tracker use this function to filter and display only the active world quests on the map, providing players with up-to-date information on available quests.