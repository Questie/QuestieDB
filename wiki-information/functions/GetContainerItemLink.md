## Title: GetContainerItemLink

**Content:**
Returns a link of the object located in the specified slot of a specified bag.
`itemLink = GetContainerItemLink(bagID, slotIndex)`

**Parameters:**
- `bagID`
  - *number* - Bag index (bagID). Valid indices are integers -2 through 11. 0 is the backpack.
- `slotIndex`
  - *number* - Slot index within the specified bag, ascending from 1. Slot 1 is typically the leftmost topmost slot.

**Returns:**
- `itemLink`
  - *string* - a chat link for the object in the specified bag slot; nil if there is no such object. This is typically, but not always an ItemLink.

**Usage:**
The following macro prints the ItemLink of the item located in bag 0, slot 1.
```lua
/run link=GetContainerItemLink(0,1); printable=gsub(link, "\\124", "\\124\\124"); print("Here's the item link for the first slot of your backpack: \\"" .. printable .. "\\"")
```

**Description:**
Since Patch 5.0.4, certain companion pets may be put in a cage and traded. The cage is not an item, but nevertheless occupies bag slots. For such caged companions, the returned link describes a battle pet ("|Hbattlet:...") rather than an item ("|Hitem:...").