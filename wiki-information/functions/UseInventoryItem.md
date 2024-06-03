## Title: UseInventoryItem

**Content:**
Use an item in a specific inventory slot.

**Miscellaneous:**
Syntax:
`UseInventoryItem(slotID)`

**Parameters:**
- `slotID`
  - The inventory slot ID
  - You can get the slot ID by using `GetInventorySlotInfo(slot)`

**Returns:**
Always nil.

**Usage:**
```lua
/script UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"));
```
After patch 1.6, you can't auto-use items anymore. Addons can no longer activate items without the press of a button. In order to use `UseInventoryItem(GetInventorySlotInfo("Trinket0Slot"))`, you will have to call it from a button, keypress, or icon as you do with spells.