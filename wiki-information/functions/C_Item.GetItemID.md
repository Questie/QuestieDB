## Title: C_Item.GetItemID

**Content:**
Needs summary.
`itemID = C_Item.GetItemID(itemLocation)`

**Parameters:**
- `itemLocation`
  - *ItemLocationMixin*🔗

**Returns:**
- `itemID`
  - *number*

**Example Usage:**
This function can be used to retrieve the unique item ID of an item located in a specific inventory slot. For instance, if you want to get the item ID of the item equipped in the main hand slot, you can use this function with the appropriate `ItemLocationMixin`.

**Addons:**
Many large addons, such as TradeSkillMaster (TSM), use this function to identify items in the player's inventory or bank to manage auctions, inventory, and crafting operations.