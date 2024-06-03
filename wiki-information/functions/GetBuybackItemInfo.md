## Title: GetBuybackItemInfo

**Content:**
Returns info for an item that can be bought back from a merchant.
`name, icon, price, quantity = GetBuybackItemInfo(slotIndex)`

**Parameters:**
- `slotIndex`
  - *number* - The index of a slot in the merchant's buyback inventory, between 1 and `GetNumBuybackItems()`.

**Returns:**
- `name`
  - *string* - The name of the item.
- `icon`
  - *number (fileID)* - Icon texture of the item.
- `price`
  - *number* - The price, in copper, it will cost to buy the item(s) back.
- `quantity`
  - *number* - The quantity of items in the stack.
- `numAvailable`
  - *number* - The number available.
- `isUsable`
  - *boolean* - True if the item is usable, false otherwise.

**Reference:**
- `GetNumBuybackItems`