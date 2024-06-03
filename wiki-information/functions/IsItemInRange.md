## Title: IsItemInRange

**Content:**
Returns whether the item is in usable range of the unit.
`inRange = IsItemInRange(item)`

**Parameters:**
- `item`
  - *number|string* : Item ID, Link or Name - If using an item name, requires the item to be in your inventory. Item IDs and links don't have this requirement.
- `unit`
  - *string?* : UnitId - Defaults to "target"

**Returns:**
- `inRange`
  - *boolean* - Whether the item is in range; Returns nil if there is no unit targeted or the item ID is invalid.

**Usage:**
Prints if you are within 4 yards range of the target by checking the item range.
`/dump IsItemInRange(90175)`

**Reference:**
- [DeadlyBossMods Usage](https://github.com/DeadlyBossMods/DeadlyBossMods/blob/9.0.21/DBM-Core/DBM-RangeCheck.lua#L57)