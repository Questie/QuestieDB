## Title: GetQuestResetTime

**Content:**
Returns the number of seconds until daily quests reset.
`nextReset = GetQuestResetTime()`

**Returns:**
- `nextReset`
  - *number* - Number of seconds until the next daily quest reset.

**Description:**
At the first UI load per login, this function returns the time since the Unix epoch instead. Appears to give the correct value as of the second `QUEST_LOG_UPDATE` event to occur after login.
In 6.x returned incorrect answers for players inside instances hosted on servers that use a different reset time (e.g., Oceanic and Brazilian players in US continental instance servers). Fixed in 7.x.

A simple test case:
```lua
print("init", GetQuestResetTime())
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("QUEST_LOG_UPDATE")
frame:SetScript("OnEvent", function(self, event)
  print(event, GetQuestResetTime())
end)
```

**Example Use Case:**
This function can be used in addons that track daily quest progress and need to reset their data or provide notifications to the player when daily quests are about to reset. For example, an addon that helps players manage their daily quest routines could use this function to display a countdown timer until the next reset.

**Addons Using This Function:**
Many quest tracking addons, such as "Questie" and "Daily Global Check," use this function to ensure they provide accurate information about daily quest availability and reset times.