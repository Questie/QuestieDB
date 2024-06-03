## Title: GetItemCount

**Content:**
Returns the number (or available charges) of an item in the inventory.
`count = GetItemCount(itemInfo)`

**Parameters:**
- `itemInfo`
  - *number|string* - Item ID, Link, or Name
- `includeBank`
  - *boolean?* - If true, includes the bank
- `includeUses`
  - *boolean?* - If true, includes each charge of an item similar to GetActionCount()
- `includeReagentBank`
  - *boolean?* - If true, includes the reagent bank

**Returns:**
- `count`
  - *number* - The number of items in your possession, or charges if includeUses is true and the item has charges.

**Usage:**
```lua
local count = GetItemCount(29434)
print("Badge of Justice:", count)

local count = GetItemCount(33312, nil, true)
print("Mana Saphire Charges:", count)

local clothInBags = GetItemCount("Netherweave Cloth")
local clothInTotal = GetItemCount("Netherweave Cloth", true)
print("Netherweave Cloth:", clothInBags, "(bags)", (clothInTotal - clothInBags), "(bank)")
```

**Reference:**
- Iriel 2007-08-27. Upcoming 2.3 Changes - Concise List. BlueTracker. Archived from the original
- slouken 2006-10-11. Re: 2.0.0 Changes - Concise List. Archived from the original