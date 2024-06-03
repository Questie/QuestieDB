## Title: UnitHealthMax

**Content:**
Returns the maximum health of the unit.
`maxHealth = UnitHealthMax(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `maxHealth`
  - *number* - Returns 0 if the unit does not exist.

**Description:**
- **Related Events:**
  - `UNIT_MAXHEALTH`
- **Available after:**
  - `PLAYER_ENTERING_WORLD` (on login)

**Example Usage:**
```lua
local unit = "player"
local maxHealth = UnitHealthMax(unit)
print("Maximum Health of the player: ", maxHealth)
```

**Common Addon Usage:**
- **Deadly Boss Mods (DBM):** Uses `UnitHealthMax` to determine the maximum health of bosses and players to provide accurate health percentage displays during encounters.
- **Recount:** Utilizes `UnitHealthMax` to track and display the maximum health of units for detailed combat analysis and reporting.