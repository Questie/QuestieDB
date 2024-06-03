## Title: GetInventoryItemBroken

**Content:**
Returns true if an inventory item has zero durability.
`isBroken = GetInventoryItemBroken(unit, invSlotId)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit whose inventory is to be queried.
- `invSlotId`
  - *number* : InventorySlotId - to be queried, obtained via `GetInventorySlotInfo`.

**Returns:**
- `isBroken`
  - *Flag* - Returns nil if the specified item is not broken, or 1 if it is.