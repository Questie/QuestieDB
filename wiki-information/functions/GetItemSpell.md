## Title: GetItemSpell

**Content:**
Returns the spell effect for an item.
`spellName, spellID = GetItemSpell(itemID or itemString or itemName or itemLink)`

**Parameters:**
One of the following four ways to specify which item to query:
- `itemId`
  - *number* - Numeric ID of the item.
- `itemName`
  - *string* - Name of an item owned by the player at some point during this session.
- `itemString`
  - *string* - A fragment of the itemString for the item, e.g. `"item:30234:0:0:0:0:0:0:0"` or `"item:30234"`.
- `itemLink`
  - *string* - The full itemLink.

**Returns:**
- `spellName`
  - *string* - The name of the spell.
- `spellID`
  - *number* - The spell's unique identifier.

**Description:**
Useful for determining whether an item is usable.