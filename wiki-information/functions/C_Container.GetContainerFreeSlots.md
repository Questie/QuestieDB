## Title: C_Container.GetContainerFreeSlots

**Content:**
Needs summary.
`freeSlots = C_Container.GetContainerFreeSlots(containerIndex)`

**Parameters:**
- `containerIndex`
  - *number*

**Returns:**
- `freeSlots`
  - *number*

**Example Usage:**
This function can be used to determine how many free slots are available in a specific container (bag). For instance, an addon that manages inventory space could use this function to alert the player when their bags are nearly full.

**Addon Usage:**
Large addons like Bagnon, which is an inventory management addon, might use this function to display the number of free slots in each bag. This helps players manage their inventory more efficiently by providing a clear overview of available space.