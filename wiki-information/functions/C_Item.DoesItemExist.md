## Title: C_Item.DoesItemExist

**Content:**
Needs summary.
```lua
itemExists = C_Item.DoesItemExist(emptiableItemLocation)
itemExists = C_Item.DoesItemExistByID(itemInfo)
```

**Parameters:**
- **DoesItemExist:**
  - `emptiableItemLocation`
    - *ItemLocationMixin*

- **DoesItemExistByID:**
  - `itemInfo`
    - *number|string* : Item ID, Link or Name

**Returns:**
- `itemExists`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific item exists in the game. For instance, it can be useful in inventory management addons to verify if an item is valid before performing operations on it.

**Addons Using This Function:**
Large addons like **Bagnon** and **ArkInventory** might use this function to ensure that items being displayed or manipulated in the inventory actually exist, preventing errors and improving user experience.