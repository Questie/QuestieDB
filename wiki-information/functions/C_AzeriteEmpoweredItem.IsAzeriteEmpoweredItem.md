## Title: C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem

**Content:**
Needs summary.
`isAzeriteEmpoweredItem = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItem(itemLocation)`
`isAzeriteEmpoweredItem = C_AzeriteEmpoweredItem.IsAzeriteEmpoweredItemByID(itemInfo)`

**Parameters:**
- **IsAzeriteEmpoweredItem:**
  - `itemLocation`
    - *ItemLocationMixin*

- **IsAzeriteEmpoweredItemByID:**
  - `itemInfo`
    - *number|string* : Item ID, Link or Name

**Returns:**
- `isAzeriteEmpoweredItem`
  - *boolean*

**Example Usage:**
This function can be used to check if a given item is an Azerite Empowered Item, which is useful for addons that manage gear sets or provide additional information about items in the player's inventory.

**Addon Usage:**
Large addons like **Pawn** and **AzeritePowerWeights** use this function to determine if an item is an Azerite Empowered Item and to provide recommendations or weights for the best Azerite traits to choose.