## Title: C_Item.GetItemName

**Content:**
Needs summary.
```lua
itemName = C_Item.GetItemName(itemLocation)
itemName = C_Item.GetItemNameByID(itemInfo)
```

**Parameters:**

**GetItemName:**
- `itemLocation`
  - *ItemLocationMixin*

**GetItemNameByID:**
- `itemInfo`
  - *number|string* - Item ID, Link or Name

**Returns:**
- `itemName`
  - *string?*

**Example Usage:**
This function can be used to retrieve the name of an item based on its location or ID. For instance, if you have an item in your inventory and you want to display its name in a custom UI element, you can use `C_Item.GetItemName` to get the name and then display it.

**Addons:**
Many large addons like **WeakAuras** and **TradeSkillMaster** use similar functions to display item names dynamically based on user interactions or inventory changes.