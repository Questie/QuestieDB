## Title: GetMerchantItemCostInfo

**Content:**
Returns "alternative currency" information about an item.
`itemCount = GetMerchantItemCostInfo(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the merchant's inventory

**Returns:**
- `itemCount`
  - *number* - The number of different types of items required to purchase the item.

**Description:**
The `itemCount` is the number of different types of items required, not how many of those types. For example, the Scout's Tabard which requires 3 Arathi Basin Marks of Honor and 3 Warsong Gulch Marks of Honor would return a 2 for the item count. To find out how many of each item is required, use the `GetMerchantItemCostItem` function.

**Reference:**
- `GetMerchantItemInfo`
- `GetMerchantItemCostItem`