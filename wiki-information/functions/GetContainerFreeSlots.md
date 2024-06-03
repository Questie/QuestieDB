## Title: GetContainerFreeSlots

**Content:**
Populates a table with references to unused slots inside a container.
```lua
returnTable = GetContainerFreeSlots(index)
GetContainerFreeSlots(index, returnTable)
```

**Parameters:**
- `index`
  - *number* - the slot containing the bag, e.g. 0 for backpack, etc.
- `returnTable`
  - *table?* - Provide an empty table and the function will populate it with the free slots

**Returns:**
- `returnTable`
  - *table* - If you do not specify `returnTable` as an argument, the function constructs and returns a new table instead

**Reference:**
- `GetContainerNumFreeSlots`