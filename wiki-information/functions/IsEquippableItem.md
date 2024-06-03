## Title: IsEquippableItem

**Content:**
Returns true if an item is equipable by the player.
`result = IsEquippableItem(itemId or itemName or itemLink)`

**Parameters:**
- `(itemId or "itemName" or "itemLink")`
  - `itemId`
    - *number* - The numeric ID of the item. e.g., 12345
  - `itemName`
    - *string* - The Name of the Item, e.g., "Heavy Silk Bandage"
  - `itemLink`
    - *string* - The itemLink, when Shift-Clicking items.

**Returns:**
- `result`
  - 1 if equip-able, nil otherwise.

**Usage:**
On a Druid:
```lua
/dump IsEquippableItem("Heavy Silk Bandage")
1
/dump IsEquippableItem("Moonkin Form")
1
/dump IsEquippableItem("Some Non-Equipable Item")
nil
```

**Example Use Case:**
This function can be used in an addon to filter out items that the player cannot equip, which is useful for inventory management addons or loot distribution systems.

**Addons Using This Function:**
- **Bagnon**: A popular inventory management addon that uses this function to determine which items can be equipped by the player, helping to organize the player's bags more efficiently.
- **Pawn**: An addon that helps players decide which gear is better for their character. It uses this function to ensure that only equippable items are considered in its calculations.