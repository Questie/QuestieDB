## Title: PickupAction

**Content:**
Places an action onto the cursor.
`PickupAction(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - The action slot to pick the action up from.

**Returns:**
- `nil`

**Description:**
If the slot is empty, nothing happens, otherwise the action from the slot is placed on the cursor, and the slot is filled with whatever action was currently being drag-and-dropped (The slot is emptied if the cursor was empty).
If you wish to empty the cursor without putting the item into another slot, try `ClearCursor`.