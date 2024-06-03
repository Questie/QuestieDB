## Title: GetLootSlotLink

**Content:**
Returns the item link for a loot slot.
`itemLink = GetLootSlotLink(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the list to retrieve info from (1 to GetNumLootItems())

**Returns:**
- `itemLink`
  - *string* - The itemLink for the specified item, or nil if index is invalid.

**Usage:**
The example below will display the item links into your chat window.
```lua
local linkstext = ""
for index = 1, GetNumLootItems() do
  if LootSlotHasItem(index) then
    local itemLink = GetLootSlotLink(index)
    linkstext = linkstext .. itemLink
  end
end
print(linkstext)
```

**Example Use Case:**
This function can be used in addons that manage loot distribution or display loot information. For instance, an addon like "LootMaster" might use this function to retrieve and display item links for all items in a loot window, allowing raid leaders to distribute loot more efficiently.