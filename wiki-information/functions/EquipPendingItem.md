## Title: EquipPendingItem

**Content:**
Equips the currently pending Bind-on-Equip or Bind-on-Pickup item from the specified inventory slot.
`EquipPendingItem(invSlot)`

**Parameters:**
- `invSlot`
  - *number* : InventorySlotId - The slot ID of the item being equipped

**Description:**
When the player attempts to use a Bind-on-Equip or Bind-on-Pickup item for the first time, the game triggers a confirmation dialog. This method appears to be an internal method used by that dialog which equips the item which activated the dialog if accepted.