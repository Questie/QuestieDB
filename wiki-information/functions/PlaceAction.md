## Title: PlaceAction

**Content:**
Places an action onto into the specified action slot.
`PlaceAction(actionSlot)`

**Parameters:**
- `actionSlot`
  - *number* - The action slot to place the action into.

**Description:**
If the cursor is empty, nothing happens, otherwise the action from the cursor is placed in the slot. If the slot was empty then the cursor becomes empty, otherwise the action from the slot is picked up and placed onto the cursor.
If an action is placed on the cursor use `API_PutItemInBackpack` to remove the action from the cursor without placing it in an action slot.

**Important:**
You can crash your client if you send an invalid slot number.