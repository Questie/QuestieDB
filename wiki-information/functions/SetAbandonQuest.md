## Title: SetAbandonQuest

**Content:**
Selects the currently selected quest to be abandoned.
`SetAbandonQuest()`

**Description:**
Quests are selected by calling `SelectQuestLogEntry()`.
After calling this function, you can abandon the quest by calling `AbandonQuest()`.

**Reference:**
`GetAbandonQuestName()`

**Example Usage:**
```lua
-- Select the quest log entry for the quest you want to abandon
SelectQuestLogEntry(questIndex)

-- Set the quest to be abandoned
SetAbandonQuest()

-- Abandon the quest
AbandonQuest()
```

**Additional Information:**
This function is often used in addons that manage quest logs, such as Questie, to provide users with the ability to abandon quests directly from the addon interface.