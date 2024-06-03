## Title: UnitRangedAttackPower

**Content:**
Returns the ranged attack power of the unit.
`attackPower, posBuff, negBuff = UnitRangedAttackPower(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - Likely only works for "player" and "pet"

**Returns:**
- `attackPower`
  - *number* - The unit's base ranged attack power (seems to give a positive number even if no ranged weapon equipped)
- `posBuff`
  - *number* - The total effect of positive buffs to ranged attack power.
- `negBuff`
  - *number* - The total effect of negative buffs to the ranged attack power (a negative number)

**Usage:**
Shows your current ranged attack power.
```lua
local base, posBuff, negBuff = UnitRangedAttackPower("player");
local effective = base + posBuff + negBuff;
print("Your current ranged attack power: " .. effective);
```