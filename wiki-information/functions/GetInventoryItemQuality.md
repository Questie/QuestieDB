## Title: GetInventoryItemQuality

**Content:**
Returns the quality of an equipped item.
`quality = GetInventoryItemQuality(unitId, invSlotId)`

**Parameters:**
- `unitId`
  - *string* : UnitId - The unit whose inventory is to be queried.
- `invSlotId`
  - *number* : InventorySlotId - The slot ID to be queried, obtained via `GetInventorySlotInfo()`.

**Returns:**
- `quality`
  - *Enum.ItemQuality*