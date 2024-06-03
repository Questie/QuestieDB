## Title: SplitContainerItem

**Content:**
Places part of a stack of items from a container onto the cursor.
`SplitContainerItem(bagID, slot, count)`

**Parameters:**
- `bagID`
  - *number* - id of the bag the slot is located in.
- `slot`
  - *number* - slot inside the bag (top left slot is 1, slot to the right of it is 2).
- `count`
  - *number* - Quantity to pick up.

**Description:**
This function always puts the requested item(s) on the cursor (unlike `PickupContainerItem()` which can pick up items, place items, or cast spells on items based on what's already on the cursor).
Passing a larger count than is in the requested bag and slot will pick up nothing.