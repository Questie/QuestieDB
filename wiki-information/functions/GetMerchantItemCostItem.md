## Title: GetMerchantItemCostItem

**Content:**
Returns info for the currency cost for a merchant item.
`itemTexture, itemValue, itemLink, currencyName = GetMerchantItemCostItem(index, itemIndex)`

**Parameters:**
- `index`
  - *number* - Slot in the merchant's inventory to query.
- `itemIndex`
  - *number* - The index for the required item cost type, ascending from 1 to itemCount returned by GetMerchantItemCostInfo.

**Returns:**
- `itemTexture`
  - *string* - The texture that represents the item's icon
- `itemValue`
  - *number* - The number of that item required
- `itemLink`
  - *string* - An itemLink for the cost item, nil if a currency.
- `currencyName`
  - *string* - Name of the currency required, nil if an item.

**Description:**
`itemIndex` counts into the number of different "alternate currency" tokens required to buy the item under consideration. For example, looking at the 25-player Tier 9 vendor, a chestpiece costs 75 Emblems of Triumph and 1 Trophy of the Crusade. This function would be called with arguments (N,1) to retrieve information about the Emblems and (N,2) to retrieve information about the Trophy, where N is the index of the chestpiece in the merchant window.