## Title: C_Item.GetItemName

**Content:**
Needs summary.
`itemName = C_Item.GetItemName(itemLocation)`
`itemName = C_Item.GetItemNameByID(itemInfo)`

**Parameters:**
- **GetItemName:**
  - `itemLocation`
    - *ItemLocationMixin*

- **GetItemNameByID:**
  - `itemInfo`
    - *number|string* - Item ID, Link, or Name

**Returns:**
- `itemName`
  - *string?*

**Description:**
The `C_Item.GetItemName` function retrieves the name of an item based on its location or ID. This can be particularly useful for addons that need to display item names dynamically, such as inventory management addons or tooltip enhancements.

**Example Usage:**
```lua
local itemLocation = ItemLocation:CreateFromBagAndSlot(bag, slot)
local itemName = C_Item.GetItemName(itemLocation)
print("Item Name: ", itemName)

local itemID = 12345
local itemNameByID = C_Item.GetItemNameByID(itemID)
print("Item Name by ID: ", itemNameByID)
```

**Addons Using This Function:**
- **Bagnon:** An inventory management addon that uses this function to display item names in the player's bags.
- **TipTac:** A tooltip enhancement addon that uses this function to show item names in tooltips.