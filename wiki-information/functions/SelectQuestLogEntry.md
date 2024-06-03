## Title: SelectQuestLogEntry

**Content:**
Makes a quest in the quest log the currently selected quest.
`SelectQuestLogEntry(questIndex)`

**Parameters:**
- `questIndex`
  - *number* - quest log entry index to select, ascending from 1.

**Description:**
This function is called whenever the user clicks on a quest name in the quest log.
It is necessary to call this function to allow other API functions that do not take a questIndex argument to return information about specific quests.