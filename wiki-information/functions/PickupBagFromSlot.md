## Title: PickupBagFromSlot

**Content:**
Picks up the bag from the specified slot, placing it in the cursor.
`PickupBagFromSlot(slot)`

**Parameters:**
- `slot`
  - *InventorySlotID* - the slot containing the bag.

**Description:**
Valid slot numbers are 20-23, numbered from left to right starting after the backpack.
`inventoryID`, the result of `ContainerIDtoInventoryID(BagID)`, can help to compute the slot number and bag numbers can be viewed in the InventorySlotID page.