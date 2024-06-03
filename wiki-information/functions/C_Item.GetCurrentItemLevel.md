## Title: C_Item.GetCurrentItemLevel

**Content:**
Needs summary.
`currentItemLevel = C_Item.GetCurrentItemLevel(itemLocation)`

**Parameters:**
- `itemLocation`
  - *ItemLocationMixin* 🔗

**Returns:**
- `currentItemLevel`
  - *number?*

**Example Usage:**
This function can be used to determine the current item level of an item in a specific location, such as a player's inventory or equipped gear. This is particularly useful for addons that need to display or compare item levels.

**Addon Usage:**
- **Pawn**: This popular addon uses `C_Item.GetCurrentItemLevel` to help players determine which items are upgrades by comparing item levels and other stats.
- **SimulationCraft**: This addon uses the function to export a player's current gear setup, including item levels, for simulation purposes.