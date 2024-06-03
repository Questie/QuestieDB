## Title: C_TaskQuest.GetQuestProgressBarInfo

**Content:**
Needs summary.
`progress = C_TaskQuest.GetQuestProgressBarInfo(questID)`

**Parameters:**
- `questID`
  - *number*

**Returns:**
- `progress`
  - *number*

**Description:**
This function retrieves the progress of a quest that has a progress bar. The progress is returned as a number, which typically represents the percentage of completion.

**Example Usage:**
```lua
local questID = 12345
local progress = C_TaskQuest.GetQuestProgressBarInfo(questID)
print("Quest Progress: " .. progress .. "%")
```

**Addons Using This Function:**
- **World Quest Tracker**: This addon uses `C_TaskQuest.GetQuestProgressBarInfo` to display the progress of world quests on the map and in the quest tracker.
- **TomTom**: This popular navigation addon may use this function to provide users with progress updates for quests that involve traveling to specific locations.