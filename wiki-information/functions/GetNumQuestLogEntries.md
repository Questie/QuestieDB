## Title: GetNumQuestLogEntries

**Content:**
Returns the number of entries in the quest log.
`numEntries, numQuests = GetNumQuestLogEntries()`

**Returns:**
- `numEntries`
  - *number* - Number of entries in the Quest Log, including collapsable zone headers.
- `numQuests`
  - *number* - Number of actual quests in the Quest Log, not counting zone headers.

**Usage:**
This snippet displays the number of visible entries (headers and non-collapsed quests) in the quest log and quest count total to the default chat frame.
```lua
local numEntries, numQuests = GetNumQuestLogEntries()
print(numEntries .. " entries containing " .. numQuests .. " quests in your quest log.")
```

**Example Use Case:**
This function can be used in addons that manage or display quest information. For instance, an addon that provides enhanced quest tracking or sorting might use this function to determine how many quests are currently in the player's quest log and display this information in a custom UI.

**Addons Using This Function:**
- **Questie:** A popular addon that enhances the questing experience by showing available quests, objectives, and turn-ins on the map. It uses `GetNumQuestLogEntries` to keep track of the number of quests the player has and to update its interface accordingly.