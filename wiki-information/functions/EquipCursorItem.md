## Title: EquipCursorItem

**Content:**
Equips the currently picked up item to a specific inventory slot.
`EquipCursorItem(slot)`

**Parameters:**
- `slot`
  - *number* - The InventorySlotId to place the item into.

**Usage:**
```lua
EquipCursorItem(GetInventorySlotInfo("HEADSLOT"));
EquipCursorItem(GetInventorySlotInfo("HEADSLOT"));
```

**Miscellaneous:**
**Result:**
Attempts to equip the currently picked up item to the head slot.