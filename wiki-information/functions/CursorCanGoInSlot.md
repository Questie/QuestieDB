## Title: CursorCanGoInSlot

**Content:**
True if the item held by the cursor can be equipped in the specified (equipment) inventory slot.
`fitsInSlot = CursorCanGoInSlot(invSlot)`

**Parameters:**
- `invSlot`
  - *number* : inventorySlotId - Inventory slot to query

**Returns:**
- `fitsInSlot`
  - *boolean* - 1 if the thing currently on the cursor can go into the specified slot, nil otherwise.