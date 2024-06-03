## Title: CanInspect

**Content:**
Returns true if the player can inspect the unit.
`canInspect = CanInspect(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId
- `showError`
  - *boolean?* - If true, the function will display an error message ("You can't inspect that unit") if you cannot inspect the specified unit.

**Returns:**
- `canInspect`
  - *boolean* - True if you can inspect the specified unit

**Description:**
You cannot inspect NPCs, nor PvP-enabled hostile players in PvP-enabled locations.

**Reference:**
- `NotifyInspect`