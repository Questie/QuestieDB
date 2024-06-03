## Title: GetItemIcon

**Content:**
Returns the icon texture for an item.
`icon = GetItemIcon(itemID)`

**Parameters:**
- `itemID`
  - *number* - The ID of the item to query e.g. 23405 for .

**Returns:**
- `icon`
  - *number* : FileID - Icon texture used by the item.

**Description:**
Unlike `GetItemInfo()`, this function does not require the item to be readily available from the item cache.