## Title: GetTradePlayerItemInfo

**Content:**
Returns information about a trade item.
`name, texture, numItems, quality, enchantment, canLoseTransmog = GetTradePlayerItemInfo(id)`

**Parameters:**
- `id`
  - *number* - The trade slot index to query.

**Returns:**
- `name`
  - *string* - The name of the item.
- `texture`
  - *number : FileDataID* - The icon associated with the item.
- `numItems`
  - *number* - For stackable items, the number of items in the stack.
- `quality`
  - *Enum.ItemQuality* - The quality of the item.
- `enchantment`
  - *string* - The name of any applied enchantment.
- `canLoseTransmog`
  - *boolean* - true if trading this item will cause the player to lose the ability to transmogrify its appearance.