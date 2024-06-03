## Title: ConfirmLootSlot

**Content:**
Confirms looting of a BoP item.
`ConfirmLootSlot(slot)`

**Parameters:**
- `slot`
  - *number* - the loot slot of a BoP loot item that is waiting for confirmation

**Description:**
If the player has already clicked on a LootButton object with loot index 1, and the item is "Bind on Pickup" and awaiting confirmation, then the item will be looted and placed in the player's bags.