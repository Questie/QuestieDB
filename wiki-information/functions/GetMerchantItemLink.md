## Title: GetMerchantItemLink

**Content:**
Returns the item link for a merchant item.
`link = GetMerchantItemLink(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the merchant's inventory

**Returns:**
- `itemLink`
  - *string?* - returns a string that will show as a clickable link to the item

**Usage:**
Show item link will appear in the default chat frame.
```lua
DEFAULT_CHAT_FRAME:AddMessage(GetMerchantItemLink(4));
```