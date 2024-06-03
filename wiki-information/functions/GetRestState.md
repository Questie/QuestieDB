## Title: GetRestState

**Content:**
Returns if the character is in a rested or normal state.
`exhaustionID, name, factor = GetRestState()`

**Returns:**
- `exhaustionID`
  - *number* - Rest state index; observed values are 1 if the player is "Rested", 2 if the player is in a normal state.
- `name`
  - *string* - Name of the current rest state; observed: "Rested" or "Normal".
- `factor`
  - *number* - XP multiplier applied to experience gain from killing monsters in the current rest state.

**Usage:**
```lua
rested = GetRestState();
if rested == 1 then
  print("You're rested. Now's the time to maximize experience gain!");
elseif rested == 2 then
  print("You're not rested. Find an inn and camp for the night?");
else
  print("You've discovered a hitherto unknown rest state. Would you like some coffee?");
end
```

**Example Use Case:**
This function can be used in addons that track player experience and suggest optimal times for leveling. For instance, an addon could notify players when they are in a rested state to maximize their experience gain from killing monsters.

**Addons Using This Function:**
- **RestedXP**: This addon uses `GetRestState` to provide players with information on their rested state, helping them plan their leveling sessions more efficiently.