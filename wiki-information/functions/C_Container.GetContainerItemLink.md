## Title: C_Container.GetContainerItemLink

**Content:**
Needs summary.
`itemLink = C_Container.GetContainerItemLink(containerIndex, slotIndex)`

**Parameters:**
- `containerIndex`
  - *number*
- `slotIndex`
  - *number*

**Returns:**
- `itemLink`
  - *string*

**Example Usage:**
This function can be used to retrieve the item link of an item in a specific bag and slot. For example, if you want to get the item link of the item in the first slot of your backpack, you would call:
```lua
local itemLink = C_Container.GetContainerItemLink(0, 1)
print(itemLink)
```

**Addons Usage:**
Many inventory management addons, such as Bagnon or ArkInventory, use this function to display item information in custom bag interfaces. They call this function to get the item link and then use the link to fetch more detailed information about the item, such as its name, quality, and tooltip.