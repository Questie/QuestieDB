## Title: GetRangedCritChance

**Content:**
Returns the ranged critical hit chance.
`critChance = GetRangedCritChance()`

**Returns:**
- `critChance`
  - *number* - The player's ranged critical hit chance, as a percentage; e.g. 5.3783211 corresponding to a ~5.38% crit chance.

**Description:**
If you are displaying this figure in a UI element and want it to update, hook to the `UNIT_INVENTORY_CHANGED` and `SPELLS_CHANGED` events as well as any other that affect equipment and buffs.