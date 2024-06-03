## Title: BuyMerchantItem

**Content:**
Buys an item from a merchant.
`BuyMerchantItem(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the merchant's inventory
- `quantity`
  - *number?* - Quantity to buy.

**Description:**
If the item is sold in stacks, the quantity specifies how many stacks will be bought.
As of 4.1, the quantity argument behavior is different:
- If you do not specify quantity and the item is sold in stacks it will buy a stack.
- If you specify quantity it will buy the specified amount, sold in stacks or not.
- The only limitation is the maximum stack allowed to buy from the merchant at one time, you can check this with the `GetMerchantItemMaxStack` function.

**Example Usage:**
```lua
-- Buy the first item in the merchant's inventory
BuyMerchantItem(1)

-- Buy 5 stacks of the second item in the merchant's inventory
BuyMerchantItem(2, 5)
```

**Addons Using This Function:**
- **Auctioneer**: Uses `BuyMerchantItem` to automate the purchase of items from merchants for resale or crafting.
- **TradeSkillMaster**: Utilizes this function to streamline the process of buying materials from vendors for crafting operations.