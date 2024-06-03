## Title: GetTradeTargetItemInfo

**Content:**
Returns item info for the other player in the trade window.
`name, texture, quantity, quality, isUsable, enchant = GetTradeTargetItemInfo(index)`

**Parameters:**
- `index`
  - *number* - the slot (1-7) to retrieve info from

**Returns:**
- `name`
  - *string* - Name of the item
- `texture`
  - *string* - Name of the item's texture
- `quantity`
  - *number* - Returns how many is in the stack
- `quality`
  - *number* - The item's quality (0-6)
- `isUsable`
  - *number* - True if the player can use this item
- `enchant`
  - *string* - enchant being applied (no trade slot)

**Example Usage:**
This function can be used to display information about the items the other player has placed in the trade window. For instance, an addon could use this to show detailed information about the items being traded, such as their quality and usability.

**Addons:**
Large addons like TradeSkillMaster (TSM) use this function to manage and display trade information, ensuring that users have all the necessary details about the items being traded.