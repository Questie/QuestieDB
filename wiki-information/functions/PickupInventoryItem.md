## Title: PickupInventoryItem

**Content:**
Picks up / interacts with an equipment slot.
`PickupInventoryItem(slotId)`

**Parameters:**
- `slotId`
  - *number* : InventorySlotId

**Description:**
If the cursor is empty, then it will attempt to pick up the item in the `slotId`.
If the cursor has an item, then it will attempt to equip the item to the `slotId` and place the previous `slotId` item (if any) where the item on cursor originated.
If the cursor is in repair or spell-casting mode, it will attempt the action on the `slotId`.
You can use `GetInventorySlotInfo` to get the `slotId`:

**Usage:**
```lua
/script PickupInventoryItem(GetInventorySlotInfo("MainHandSlot"))
/script PickupInventoryItem(GetInventorySlotInfo("SecondaryHandSlot"))
```
The above attempts a main hand/off-hand weapon swap. It will pick up the weapon from the main hand and then pick up the weapon from the off-hand, attempting to equip the main hand weapon to off-hand and sending the off-hand to main hand if possible.