## Title: C_NewItems.IsNewItem

**Content:**
Returns true if the item in the inventory slot is flagged as new.
`isNew = C_NewItems.IsNewItem(containerIndex, slotIndex)`

**Parameters:**
- `containerIndex`
  - *number* - BagID of the container.
- `slotIndex`
  - *number* - ID of the inventory slot within the container.

**Returns:**
- `isNew`
  - *boolean* - Returns true if the inventory slot holds a newly-acquired item; otherwise false (empty slot or a non-new item).

**Reference:**
- `C_NewItems.RemoveNewItem(bag, slot)` - Used by FrameXML/ContainerFrame.lua to clear the new-item flag after interacting with the new item or closing the bags.
- `IsBattlePayItem(bag, slot)` - Used by FrameXML/ContainerFrame.lua to emphasize recent purchases from the In-Game Store.