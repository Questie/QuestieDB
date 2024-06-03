## Title: GetQuestLogTitle

**Content:**
Returns information about a quest in your quest log.
`title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(questLogIndex)`

**Parameters:**
- `questLogIndex`
  - *number* - The index of the quest you wish to get information about, between 1 and `GetNumQuestLogEntries()`'s first return value.

**Returns:**
- `title`
  - *string* - The title of the quest, or nil if the index is out of range.
- `level`
  - *number* - The level of the quest.
- `suggestedGroup`
  - *number* - If the quest is designed for more than one player, it is the number of players suggested to complete the quest. Otherwise, it is 0.
- `isHeader`
  - *boolean* - true if the entry is a header, false otherwise.
- `isCollapsed`
  - *boolean* - true if the entry is a collapsed header, false otherwise.
- `isComplete`
  - *number* - 1 if the quest is completed, -1 if the quest is failed, nil otherwise.
- `frequency`
  - *number* - 1 if the quest is a normal quest, `LE_QUEST_FREQUENCY_DAILY` (2) for daily quests, `LE_QUEST_FREQUENCY_WEEKLY` (3) for weekly quests.
- `questID`
  - *number* - The quest identification number. This is the number found in `GetQuestsCompleted()` after it has been completed. It is also the number used to identify quests on sites such as Wowhead.com (Example: Rest and Relaxation)
- `startEvent`
  - *boolean* - ?
- `displayQuestID`
  - *boolean* - true if the questID is displayed before the title, false otherwise.
- `isOnMap`
  - *boolean* - ?
- `hasLocalPOI`
  - *boolean* - ?
- `isTask`
  - *boolean* - ?
- `isBounty`
  - *boolean* - ? (true for Legion World Quests; is it true for other WQs?)
- `isStory`
  - *boolean* - ?
- `isHidden`
  - *boolean* - true if the quest is not visible inside the player's quest log.
- `isScaling`
  - *boolean* - ?

**Usage:**
```lua
local i = 1
while GetQuestLogTitle(i) do
  local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden, isScaling = GetQuestLogTitle(i)
  if ( not isHeader ) then
    DEFAULT_CHAT_FRAME:AddMessage(title .. " " .. questID)
  end
  i = i + 1
end
```

**Miscellaneous:**
Result:
Prints the name, level, and Quest ID of all quests in your quest log.