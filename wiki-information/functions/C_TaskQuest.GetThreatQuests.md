## Title: C_TaskQuest.GetThreatQuests

**Content:**
Needs summary.
`quests = C_TaskQuest.GetThreatQuests()`

**Returns:**
- `quests`
  - *number*

**Description:**
This function retrieves the list of threat quests available. Threat quests are typically world quests that have a higher level of difficulty or importance. 

**Example Usage:**
```lua
local threatQuests = C_TaskQuest.GetThreatQuests()
for _, questID in ipairs(threatQuests) do
    print("Threat Quest ID:", questID)
end
```

**Addons:**
Large addons like World Quest Tracker may use this function to display or track threat quests separately from regular world quests, providing players with information on more challenging or significant quests available in the game world.