## Title: GetRangedHaste

**Content:**
Returns the player's ranged haste amount granted through buffs.
`haste = GetRangedHaste()`

**Returns:**
- `haste`
  - *number* - The player's ranged haste amount granted through buffs, as a percentage; e.g. 36.36363 corresponding to a ~36.36% increased attack speed.

**Description:**
Reports only the ranged haste granted from buffs, such as and Quick Shots (from ) but excluding a hunter's quiver.

**Related API:**
- `GetCombatRating(CR_HASTE_RANGED)`
- `GetCombatRatingBonus(CR_HASTE_RANGED)`