## Title: GetMerchantItemInfo

**Content:**
Returns info for a merchant item.
`name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the merchant's inventory

**Returns:**
- `name`
  - *string* - The name of the item
- `texture`
  - *string* - The texture that represents the item's icon
- `price`
  - *number* - The price of the item (in copper)
- `quantity`
  - *number* - The quantity that will be purchased (the batch size, e.g. 5 for vials)
- `numAvailable`
  - *number* - The number of this item that the merchant has in stock. -1 for unlimited stock.
- `isPurchasable`
  - *boolean* - Is true if the item can be purchased, false otherwise
- `isUsable`
  - *boolean* - Is true if the player can use this item, false otherwise
- `extendedCost`
  - *boolean* - Is true if the item has extended (PvP) cost info, false otherwise

**Usage:**
```lua
local name, texture, price, quantity, numAvailable, isUsable, extendedCost = GetMerchantItemInfo(4);
message(name .. " " .. price .. "c");
```

**Miscellaneous:**
Result:
A message stating the name and price of the item in merchant slot 4 appears.

**Reference:**
- `GetMerchantItemCostInfo`

**Example Use Case:**
This function can be used in an addon to display detailed information about items sold by NPC merchants. For instance, an addon could use this function to create a custom merchant interface that shows additional information about each item, such as its price in a more readable format or whether the player can use the item.

**Addons Using This Function:**
Many popular addons like Auctioneer and TradeSkillMaster use this function to gather information about items sold by merchants, which can then be used to help players make informed purchasing decisions or to automate buying processes.