## Title: C_Item.IsLocked

**Content:**
Needs summary.
`isLocked = C_Item.IsLocked(itemLocation)`

**Parameters:**
- `itemLocation`
  - *ItemLocationMixin*🔗

**Returns:**
- `isLocked`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific item in a player's inventory is currently locked (e.g., due to being in use or being a quest item).

**Addon Usage:**
Large addons like **Bagnon** or **ArkInventory** might use this function to determine the lock status of items when displaying inventory grids, ensuring that locked items are visually distinct or handled differently in the UI.