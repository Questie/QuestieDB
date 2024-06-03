## Title: LootSlot

**Content:**
Loots the specified slot; can require confirmation with `ConfirmLootSlot`.
`LootSlot(slot)`

**Parameters:**
- `slot`
  - *number* - the loot slot.

**Returns:**
- unknown

**Usage:**
```lua
LootSlot(1)
-- if slot 1 contains an item that must be confirmed, then
ConfirmLootSlot(1)
-- must be called after.
```

**Miscellaneous:**
Result:

This function is called whenever a LootButton is clicked (or auto looted).