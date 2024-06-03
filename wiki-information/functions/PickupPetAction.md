## Title: PickupPetAction

**Content:**
Places a pet action onto the cursor.
`PickupPetAction(petActionSlot)`

**Parameters:**
- `petActionSlot`
  - *number* - The pet action slot to pick the action up from (1-10).

**Description:**
If the slot is empty, nothing happens, otherwise the action from the slot is placed on the cursor, and the slot is filled with whatever action was currently being drag-and-dropped (The slot is emptied if the cursor was empty).