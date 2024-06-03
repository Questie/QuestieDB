## Title: UnitXPMax

**Content:**
Returns the maximum XP of the unit; only works on the player.
`nextXP = UnitXPMax(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `nextXP`
  - *number* - Returns the max XP points of the "unit".

**Usage:**
```lua
local xp = UnitXP("player")
local nextXP = UnitXPMax("player")
print(string.format("Your XP is currently at %.1f%%", xp / nextXP * 100))
```

**Example Use Case:**
This function can be used to create an experience bar for the player in a custom UI addon. By knowing the current XP and the maximum XP, you can calculate the percentage of XP the player has gained towards the next level.

**Addons Using This Function:**
Many popular addons like "ElvUI" and "Bartender4" use this function to display the player's experience bar, showing progress towards the next level.