## Title: GetContainerNumFreeSlots

**Content:**
Returns the number of free slots in a bag.
`numberOfFreeSlots, bagType = GetContainerNumFreeSlots(bagID)`

**Parameters:**
- `bagID`
  - *number* - the slot containing the bag, e.g. 0 for backpack, etc.

**Returns:**
- `numberOfFreeSlots`
  - *number* - the number of free slots in the specified bag.
- `bagType`
  - *number (itemFamily Bitfield)* - The type of the container, described using bits to indicate its permissible contents.

**Reference:**
- `GetContainerFreeSlots` - Returns a table containing references to each free slot