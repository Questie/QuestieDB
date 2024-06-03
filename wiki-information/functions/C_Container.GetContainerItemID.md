## Title: C_Container.GetContainerItemID

**Content:**
Needs summary.
`itemID = C_Container.GetContainerItemID(containerIndex, slotIndex)`

**Parameters:**
- `containerIndex`
  - *number*
- `slotIndex`
  - *number*

**Returns:**
- `itemID`
  - *number?*

**Example Usage:**
This function can be used to retrieve the item ID of an item in a specific slot of a container (bag). For example, if you want to check what item is in the first slot of your backpack, you could use:
```lua
local itemID = C_Container.GetContainerItemID(0, 1)
print("Item ID in first slot of backpack:", itemID)
```

**Addons Usage:**
Many inventory management addons, such as Bagnon or ArkInventory, use this function to identify items in the player's bags to provide enhanced bag management features.