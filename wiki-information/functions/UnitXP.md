## Title: UnitXP

**Content:**
Returns the current XP of the unit; only works on the player.
`xp = UnitXP(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `xp`
  - *number* - Returns the current XP points of the unit.

**Description:**
This does not work for hunter pets, use `GetPetExperience()` for that.

**Related Events:**
- `PLAYER_XP_UPDATE`

**Related API:**
- `UnitXPMax`

**Usage:**
```lua
local xp = UnitXP("player")
local nextXP = UnitXPMax("player")
print(string.format("Your XP is currently at %.1f%%", xp / nextXP * 100))
```

**Example Use Case:**
This function can be used in an addon to track the player's experience points and display progress towards the next level. For instance, an addon could use this to create a custom XP bar or to notify the player when they are close to leveling up.

**Addons Using This API:**
Many leveling and UI enhancement addons, such as "ElvUI" and "Titan Panel," use `UnitXP` to display the player's current experience points and progress towards the next level.