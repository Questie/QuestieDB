## Title: UnitLevel

**Content:**
Returns the level of the unit.
`level = UnitLevel(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - For example "player" or "target"

**Returns:**
- `level`
  - *number* - The unit level. Returns -1 for boss units or hostile units 10 levels above the player (Level ??).

**Description:**
- When calling `UnitLevel("player")` on `PLAYER_LEVEL_UP` it might be incorrect, check the payload instead to be sure.
- When inebriated, the apparent level of hostile units is lowered by up to 5.

**Related API:**
- `UnitEffectiveLevel`

**Related Events:**
- `PLAYER_LEVEL_UP`
- `PLAYER_LEVEL_CHANGED`

**Example Usage:**
```lua
local playerLevel = UnitLevel("player")
print("Player level is: " .. playerLevel)
```

**Usage in Addons:**
- **Recount**: Uses `UnitLevel` to determine the level of units for accurate damage and healing statistics.
- **Details! Damage Meter**: Utilizes `UnitLevel` to provide detailed combat logs and performance metrics based on the level of units involved in combat.