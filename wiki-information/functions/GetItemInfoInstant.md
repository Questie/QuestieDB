## Title: C_Item.GetItemInfoInstant

**Content:**
Returns readily available info for an item.
`itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID = C_Item.GetItemInfoInstant(itemInfo)`

**Parameters:**
- `item`
  - *number|string* : Item ID, Link or Name
  - Accepts any valid item ID.
  - Accepts an item link, or minimally in item:%d format.
  - Accepts a localized item name but this requires the item to be or have been in the player's inventory (bags/bank) for that session.

**Returns:**
- `itemID`
  - *number* - ID of the item.
- `itemType`
  - *string* : ItemType - The localized type name of the item: Armor, Weapon, Quest, etc.
- `itemSubType`
  - *string* : ItemType - The localized sub-type name of the item: Bows, Guns, Staves, etc.
- `itemEquipLoc`
  - *string* : ItemEquipLoc - The inventory equipment location in which the item may be equipped e.g. "INVTYPE_HEAD", or an empty string if it cannot be equipped.
- `icon`
  - *number* : fileID - The texture for the item icon.
- `classID`
  - *number* : ItemType - The numeric ID of itemType
- `subClassID`
  - *number* : ItemType - The numeric ID of itemSubType

**Description:**
This function only returns info that doesn't require a query to the server. Which has the advantage over `GetItemInfo()` as it will always return data for valid items.

**Usage:**
Prints item information for 
```lua
/dump GetItemInfoInstant(4306)
-- Output:
-- 4306, -- itemID
-- "Tradeskill", -- itemType
-- "Cloth", -- itemSubType
-- "", -- itemEquipLoc
-- 132905, -- icon
-- 7, -- classID
-- 5 -- subclassID
```