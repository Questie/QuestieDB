## Title: C_TaskQuest.GetQuestInfoByQuestID

**Content:**
Needs summary.
`questTitle, factionID, capped, displayAsObjective = C_TaskQuest.GetQuestInfoByQuestID(questID)`

**Parameters:**
- `questID`
  - *number*

**Returns:**
- `questTitle`
  - *string*
- `factionID`
  - *number?* : FactionID
- `capped`
  - *boolean?*
- `displayAsObjective`
  - *boolean?*

**Example Usage:**
This function can be used to retrieve detailed information about a specific task quest by its quest ID. For instance, it can be used in an addon to display quest information in a custom quest tracker.

**Addons Using This Function:**
Large addons like World Quest Tracker use this function to fetch and display information about world quests, including their titles, associated factions, and whether they are capped or displayed as objectives.