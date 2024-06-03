## Title: GetQuestLogPushable

**Content:**
Returns true if the currently loaded quest in the quest window is able to be shared with other players.
`isPushable = GetQuestLogPushable()`

**Returns:**
- `isPushable`
  - *boolean* - 1 if the quest can be shared, nil otherwise.

**Usage:**
```lua
-- Determine whether the selected quest is pushable or not
if ( GetQuestLogPushable() and GetNumPartyMembers() > 0 ) then
  QuestFramePushQuestButton:Enable();
else
  QuestFramePushQuestButton:Disable();
end
```

**Miscellaneous:**
Result:
QuestFramePushQuestButton is enabled or disabled based on whether the currently active quest is sharable (and you being in a party!).

**Description:**
Use `SelectQuestLogEntry(questID)` to set the currently active quest before calling `GetQuestLogPushable()`. To initiate pushing (sharing) of a quest, use `QuestLogPushQuest()`.

**Example Use Case:**
This function can be used in an addon that manages quest sharing within a party. For instance, an addon could automatically enable or disable the quest sharing button based on whether the selected quest is shareable and if the player is in a party.

**Addons Using This Function:**
Many quest management addons, such as Questie, use this function to determine if a quest can be shared with party members. This helps in automating the process of sharing quests, ensuring that all party members are on the same page.