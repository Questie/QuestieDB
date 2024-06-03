## Title: GetComboPoints

**Content:**
Returns the amount of current combo points.
`comboPoints = GetComboPoints(unit, target)`

**Parameters:**
- `unit`
  - *string* : UnitId - Normally "player" or "vehicle".
- `target`
  - *string* : UnitId - Normally "target".

**Returns:**
- `comboPoints`
  - *number* - Number of combo points unit has on target; between 0 and 5 inclusive.

**Description:**
`UNIT_COMBO_POINTS` fires when combo points are updated. It fires every 10 seconds outside of combat if the rogue has shared combo points, and it continues to fire every 10 seconds until the combo point pool is empty.

Patch 6.0.2 (2014-10-14): Combo Points for rogues are now shared across all targets and they are no longer lost when switching targets.

`GetComboPoints` will return 0 if the target is friendly or not found. Use `UnitPower(unitId, 4)` to get combo points without an enemy targeted.

**Reference:**
- `UnitPower`

**Example Usage:**
```lua
local comboPoints = GetComboPoints("player", "target")
print("Current combo points on target: ", comboPoints)
```

**Addons Using This Function:**
- **ElvUI**: A comprehensive UI replacement addon that uses `GetComboPoints` to display combo points on the unit frames.
- **WeakAuras**: A powerful and flexible framework for displaying highly customizable graphics on your screen to indicate buffs, debuffs, and other relevant information, including combo points.