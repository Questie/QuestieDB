## Title: C_Heirloom.GetHeirloomInfo

**Content:**
Returns information about a heirloom by itemID.
`name, itemEquipLoc, isPvP, itemTexture, upgradeLevel, source, searchFiltered, effectiveLevel, minLevel, maxLevel = C_Heirloom.GetHeirloomInfo(itemID)`

**Parameters:**
- `itemID`
  - *number* - a heirloom itemID

**Returns:**
- `name`
  - *string* - false if not a heirloom item
- `itemEquipLoc`
  - *string*
- `isPvP`
  - *boolean*
- `itemTexture`
  - *string*
- `upgradeLevel`
  - *number*
- `source`
  - *number* - heirloom source index
- `searchFiltered`
  - *boolean*
- `effectiveLevel`
  - *number*
- `minLevel`
  - *number*
- `maxLevel`
  - *number*

**Example Usage:**
This function can be used to retrieve detailed information about a specific heirloom item, which can be useful for addons that manage heirloom collections or display heirloom information to the player.

**Addons:**
Large addons like "Altoholic" use this function to display heirloom information across multiple characters, helping players keep track of their heirloom collections.