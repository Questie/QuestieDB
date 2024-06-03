## Title: PutItemInBag

**Content:**
Places the item on the cursor into the specified bag.
`hadItem = PutItemInBag(inventoryID)`

**Parameters:**
- `inventoryID`
  - *number?* : InventorySlotId - Values from `CONTAINER_BAG_OFFSET + 1` to `CONTAINER_BAG_OFFSET + NUM_TOTAL_EQUIPPED_BAG_SLOTS` correspond to the player's bag slots, right-to-left from the first bag after the backpack.

**Returns:**
- `hadItem`
  - *boolean?* - True if the cursor had an item.

**Description:**
Puts the item on the cursor into the specified bag on the main bar, if it's a bag. Otherwise, attempts to place the item inside the bag in that slot. Note that to place an item in the backpack, you must use `PutItemInBackpack`.

**Usage:**
The following puts the item on the cursor (if it's not a bag) into the first bag (not including the backpack) starting from the right.
```lua
PutItemInBag(CONTAINER_BAG_OFFSET + 1)
```