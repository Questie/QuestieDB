## Title: UnitTrialXP

**Content:**
Needs summary.
`xp = UnitTrialXP(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `xp`
  - *number*

**Example Usage:**
This function can be used to retrieve the experience points (XP) of a trial character. For instance, if you want to display the current XP of a trial character in your addon, you can use this function.

**Example Code:**
```lua
local unit = "player" -- or any other unit token
local xp = UnitTrialXP(unit)
print("Current XP for unit:", xp)
```

**Addons Using This Function:**
While specific large addons using this function are not well-documented, it is likely used in addons that manage or display character statistics, especially those that cater to trial characters.