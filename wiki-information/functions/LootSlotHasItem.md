## Title: LootSlotHasItem

**Content:**
Returns whether a loot slot contains an item.
`isLootItem = LootSlotHasItem(lootSlot)`

**Parameters:**
- `lootSlot`
  - *number* - index of the loot slot, ascending from 1 to `GetNumLootItems()`

**Returns:**
- `isLootItem`
  - *boolean* - true if the loot slot contains an item rather than coin.

**Usage:**
Iterate through the items in the currently opened loot window and display them in the chat frame, side by side.
```lua
local itemLinkText
for i = 1, GetNumLootItems() do
  if (LootSlotHasItem(i)) then
    local iteminfo = GetLootSlotLink(i)
    if itemLinkText == nil then
      itemLinkText = iteminfo
    else
      itemLinkText = itemLinkText .. ", " .. iteminfo
    end
  end
end
print(itemLinkText)
```

**Example Use Case:**
This function can be used in addons that manage loot distribution, such as auto-looting systems or loot tracking addons. For example, an addon could use this function to filter out coin slots and only process item slots for further actions like auto-looting specific items or displaying item links in the chat.

**Addons Using This Function:**
- **LootMaster:** This addon uses `LootSlotHasItem` to determine which slots contain items and then processes those items for master looting purposes.
- **AutoLootPlus:** This addon uses the function to enhance the auto-looting experience by filtering out coin slots and focusing on item slots, allowing for more efficient looting.