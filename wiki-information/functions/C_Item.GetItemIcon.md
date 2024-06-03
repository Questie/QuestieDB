## Title: C_Item.GetItemIcon

**Content:**
Needs summary.
```lua
icon = C_Item.GetItemIcon(itemLocation)
icon = C_Item.GetItemIconByID(itemInfo)
```

**Parameters:**

*GetItemIcon:*
- `itemLocation`
  - *ItemLocationMixin*

*GetItemIconByID:*
- `itemInfo`
  - *number|string* : Item ID, Link or Name

**Returns:**
- `icon`
  - *number?* : FileID

**Reference:**
- `GetItemIcon()`

**Example Usage:**
This function can be used to retrieve the icon of an item, which can be useful for displaying item icons in custom UI elements or addons.

**Addon Usage:**
Large addons like **WeakAuras** and **ElvUI** might use this function to display item icons dynamically based on the player's inventory or equipment. For instance, WeakAuras could use it to show an icon of a specific item when certain conditions are met, enhancing the visual feedback for players.