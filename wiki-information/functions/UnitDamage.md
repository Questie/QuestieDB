## Title: UnitDamage

**Content:**
Returns the damage stats for the unit.
`minDamage, maxDamage, offhandMinDamage, offhandMaxDamage, posBuff, negBuff, percent = UnitDamage(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - Likely only works for "player" and "pet". Possibly for "target".

**Returns:**
- `minDamage`
  - *number* - The unit's minimum melee damage.
- `maxDamage`
  - *number* - The unit's maximum melee damage.
- `offhandMinDamage`
  - *number* - The unit's minimum offhand melee damage.
- `offhandMaxDamage`
  - *number* - The unit's maximum offhand melee damage.
- `posBuff`
  - *number* - positive physical Bonus (should be >= 0)
- `negBuff`
  - *number* - negative physical Bonus (should be <= 0)
- `percent`
  - *number* - percentage modifier (usually 1; 0.9 for warriors in defensive stance)

**Description:**
Doesn't seem to return usable values for mobs, NPCs. The method returns 7 values, only some of which appear to be useful.