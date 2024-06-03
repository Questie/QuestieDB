## Title: UnitAttackPower

**Content:**
Returns the unit's melee attack power and modifiers.
`base, posBuff, negBuff = UnitAttackPower(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to get information from. (Does not work for "target" - Possibly only "player" and "pet")

**Returns:**
- `base`
  - *number* - The unit's base attack power
- `posBuff`
  - *number* - The total effect of positive buffs to attack power.
- `negBuff`
  - *number* - The total effect of negative buffs to the attack power (a negative number)

**Usage:**
Displays the player's current attack power in the default chat window.
```lua
local base, posBuff, negBuff = UnitAttackPower("player")
local effective = base + posBuff + negBuff
print("Your current attack power: "..effective)
```