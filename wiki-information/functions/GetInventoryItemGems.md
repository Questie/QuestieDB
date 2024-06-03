## Title: GetInventoryItemGems

**Content:**
Returns item ids of the gems socketed in the item in the specified inventory slot.
`gem1, gem2, ... = GetInventoryItemGems(invSlot);`

**Parameters:**
- `invSlot`
  - *Number (InventorySlotId)* - Index of the inventory slot to query.

**Returns:**
- `gem1, gem2, ...`
  - *Number* - Item ID of the gem(s) socketed within the item in the queried slot.