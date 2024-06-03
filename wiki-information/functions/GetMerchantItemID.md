## Title: GetMerchantItemID

**Content:**
Returns the itemID of an item of the current merchant window.
`itemID = GetMerchantItemID(Index)`

**Parameters:**
- `Index`
  - *number* - Index

**Returns:**
- `itemID`
  - *itemID* - itemID of Merchant Item at Index

**Usage:**
To get the itemID of an item of the current merchant window:
```lua
/dump GetMerchantItemID(1) -- = 194298
```