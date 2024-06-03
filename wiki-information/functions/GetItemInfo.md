## Title: C_Item.GetItemInfo

**Content:**
Returns info for an item.
`itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType, expansionID, setID, isCraftingReagent = C_Item.GetItemInfo(itemInfo)`

**Parameters:**
- `item`
  - *number|string* : Item ID, Link or Name
  - Accepts any valid item ID but returns nil if the item is not cached yet.
  - Accepts an item link, or minimally in item:%d format.
  - Accepts a localized item name but this requires the item to be or have been in the player's inventory (bags/bank) for that session.

**Returns:**
Returns nil if the item is not cached yet or does not exist.
1. `itemName`
   - *string* - The localized name of the item.
2. `itemLink`
   - *string : ItemLink* - The localized link of the item.
3. `itemQuality`
   - *number : Enum.ItemQuality* - The quality of the item, e.g. 2 for Uncommon and 3 for Rare quality items.
4. `itemLevel`
   - *number* - The base item level, not including upgrades. See GetDetailedItemLevelInfo() for getting the actual item level.
5. `itemMinLevel`
   - *number* - The minimum level required to use the item, or 0 if there is no level requirement.
6. `itemType`
   - *string : ItemType* - The localized type name of the item: Armor, Weapon, Quest, etc.
7. `itemSubType`
   - *string : ItemType* - The localized sub-type name of the item: Bows, Guns, Staves, etc.
8. `itemStackCount`
   - *number* - The max amount of an item per stack, e.g. 200 for Runecloth.
9. `itemEquipLoc`
   - *string : ItemEquipLoc* - The inventory equipment location in which the item may be equipped e.g. "INVTYPE_HEAD", or an empty string if it cannot be equipped.
10. `itemTexture`
    - *number : FileID* - The texture for the item icon.
11. `sellPrice`
    - *number* - The vendor price in copper, or 0 for items that cannot be sold.
12. `classID`
    - *number : ItemType* - The numeric ID of itemType
13. `subclassID`
    - *number : ItemType* - The numeric ID of itemSubType
14. `bindType`
    - *number : Enum.ItemBind* - When the item becomes soulbound, e.g. 1 for Bind on Pickup items.
15. `expansionID`
    - *number : LE_EXPANSION* - The related Expansion, e.g. 8 for Shadowlands. On Classic this appears to be always 254.
16. `setID`
    - *number? : ItemSetID* - For example 761 for (itemID 21524).
17. `isCraftingReagent`
    - *boolean* - Whether the item can be used as a crafting reagent.

**Usage:**
Prints item information for 
```lua
/dump GetItemInfo(4306)
-- Returns:
-- "Silk Cloth", -- itemName
-- "|cffffffff|Hitem:4306::::::::53:258:::::::|h|h|r", -- itemLink
-- 1, -- itemQuality: Enum.ItemQuality.Common
-- 13, -- itemLevel 
-- 0, -- itemMinLevel 
-- "Tradeskill", -- itemType 
-- "Cloth", -- itemSubType 
-- 200, -- itemStackCount 
-- "", -- itemEquipLoc
-- 132905, -- itemTexture 
-- 150, -- sellPrice
-- 7, -- classID: LE_ITEM_CLASS_TRADEGOODS
-- 5, -- subclassID 
-- 0, -- bindType: Enum.ItemBind.None
-- 0, -- expansionID: LE_EXPANSION_CLASSIC
-- nil, -- setID
-- true -- isCraftingReagent
```

Item information may not have been cached. You can use `ItemMixin:ContinueOnItemLoad()` to asynchronously query the data.
```lua
local item = Item:CreateFromItemID(21524)
item:ContinueOnItemLoad(function()
    local name = item:GetItemName() 
    local icon = item:GetItemIcon()
    print(name, icon) -- "Red Winter Hat", 133169
end)
```

**Reference:**
- `GetItemInfoInstant()`