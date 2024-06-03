## Title: UnitSelectionColor

**Content:**
Returns the color of the outline and circle underneath the unit.
`red, green, blue, alpha = UnitSelectionColor(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit whose selection color should be returned.
- `useExtendedColors`
  - *boolean? = false* - If true, a more appropriate color of the unit's selection will be returned. For instance, if used on a dead hostile target, the default return will be red (hostile), but the extended return will be grey (dead).

**Returns:**
- `red`
  - *number* - A number between 0 and 1.
- `green`
  - *number* - A number between 0 and 1.
- `blue`
  - *number* - A number between 0 and 1.
- `alpha`
  - *number* - A number between 0 and 1.

**Usage:**
```lua
0, 0, 0.99999779462814, 0.99999779462814 = UnitSelectionColor("player")
0, 0.99999779462814, 0, 0.99999779462814 = UnitSelectionColor("target") -- a friendly npc in target
```

**Reference:**
API UnitSelectionType