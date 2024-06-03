## Title: EquipItemByName

**Content:**
Equips an item, optionally into a specified slot.
`EquipItemByName(itemId or itemName or itemLink)`

**Parameters:**
- `(itemId or "itemName" or "itemLink")`
  - `itemId`
    - *number* - The numeric ID of the item. i.e., 12345
  - `itemName`
    - *string* - The name of the item, i.e., "Worn Dagger". Partial names are valid inputs as well, i.e., "Worn". If several items with the same piece of name exist, the first one found will be equipped.
  - `itemLink`
    - *string* - The itemLink, when Shift-Clicking items.
  - `slot`
    - *number?* - The inventory slot to put the item in, obtained via `GetInventorySlotInfo()`.

**Reference:**
- Blue post confirming 3.3.0 change.