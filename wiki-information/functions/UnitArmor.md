## Title: UnitArmor

**Content:**
Returns the armor stats for the unit.
```lua
base, effectiveArmor, armor, bonusArmor = UnitArmor(unit) -- retail
base, effectiveArmor, armor, posBuff, negBuff = UnitArmor(unit) -- classic
```

**Parameters:**
- `unit`
  - *string* : UnitToken - Only works for "player" and "pet". Works for "target" with Hunter's Beast Lore.

**Returns:**
- `base`
  - *number* - The unit's base armor.
- `effectiveArmor`
  - *number* - The unit's effective armor.
- `armor`
  - *number*
- `bonusArmor` (Retail)
  - *number*
- `posBuff` (Classic)
  - *number* - Amount of armor increase due to positive buffs
- `negBuff` (Classic)
  - *number* - Amount of armor reduction due to negative buffs (a negative number)

**Usage:**
```lua
local base, effectiveArmor = UnitArmor("player")
print(format("Your current armor is %d (%d base)", effectiveArmor, base))
```

**Example Use Case:**
This function can be used to display a player's current armor stats in a custom UI or addon, helping players understand their defensive capabilities.

**Addons Using This Function:**
- **Details! Damage Meter**: This popular addon uses `UnitArmor` to calculate and display detailed statistics about a player's defensive stats, helping players optimize their gear and buffs.