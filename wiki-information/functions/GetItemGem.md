## Title: GetItemGem

**Content:**
Returns the gem for a socketed equipment item.
`itemName, itemLink = GetItemGem(item, index)`

**Parameters:**
- `item`
  - *string* - The name of the equipment item (the item must be equipped or in your inventory for this to work) or the ItemLink
- `index`
  - *number* - The index of the desired gem: 1, 2, or 3

**Returns:**
- `itemName`
  - *string* - The name of the gem at the specified index.
- `itemLink`
  - *string* - ItemLink

**Description:**
Using the name may be ambiguous if you have more than one of the named item.

**Usage:**
Prints the 2nd gem socketed in this item.
```lua
local link = "|cff0070dd|Hitem:87451:::41438:::::53:257:::1:6658:2:9:35:28:1035:::|h|h|r"
print(GetItemGem(link, 2)) -- "Perfect Brilliant Bloodstone", "|cff1eff00|Hitem:41438::::::::53:257:::::::|h|h|r"
```