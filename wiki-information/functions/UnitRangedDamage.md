## Title: UnitRangedDamage

**Content:**
Returns the ranged attack speed and damage of the unit.
`speed, minDamage, maxDamage, posBuff, negBuff, percent = UnitRangedDamage(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit to get information from. (Likely only works for "player" and "pet" -- unconfirmed)

**Returns:**
- `speed`
  - *number* - The unit's ranged weapon speed (0 if no ranged weapon equipped).
- `minDamage`
  - *number* - The unit's minimum ranged damage.
- `maxDamage`
  - *number* - The unit's maximum ranged damage.
- `posBuff`
  - *number* - The unit's positive Bonus on ranged attacks (includes Spelldamage increases)
- `negBuff`
  - *number* - The unit's negative Bonus on ranged attacks
- `percent`
  - *number* - percentage modifier (usually 1)

**Usage:**
Calculates your average damage per second.
```lua
local speed, lowDmg, hiDmg = UnitRangedDamage("player");
local avgDmg = (lowDmg + hiDmg) / 2;
local avgDps = avgDmg / speed;
```

**Example Use Case:**
This function can be used to calculate the average damage per second (DPS) for a player's ranged weapon. This is particularly useful for hunters or any class that relies on ranged attacks to optimize their damage output.

**Addons:**
Large addons like Recount or Details! Damage Meter might use this function to provide detailed statistics on a player's ranged damage output, helping players to analyze and improve their performance in combat.