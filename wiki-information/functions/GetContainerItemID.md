## Title: GetContainerItemID

**Content:**
Returns the item ID in a container slot.
`itemId = GetContainerItemID(bag, slot)`

**Parameters:**
- `bag`
  - *number (BagID)* - Index of the bag to query.
- `slot`
  - *number* - Index of the slot within the bag to query; ascending from 1.

**Returns:**
- `itemId`
  - *number* - item ID of the item held in the container slot, nil if there is no item in the container slot.