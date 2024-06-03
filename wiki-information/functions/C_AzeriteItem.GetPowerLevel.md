## Title: C_AzeriteItem.GetPowerLevel

**Content:**
Needs summary.
`powerLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)`

**Parameters:**
- `azeriteItemLocation`
  - *ItemLocationMixin* 🔗

**Returns:**
- `powerLevel`
  - *number*

**Description:**
This function retrieves the power level of an Azerite item at a specified location. The power level indicates the current level of Azerite power that has been unlocked for the item.

**Example Usage:**
```lua
local azeriteItemLocation = ItemLocation:CreateFromBagAndSlot(bagID, slotID)
local powerLevel = C_AzeriteItem.GetPowerLevel(azeriteItemLocation)
print("Azerite Power Level: ", powerLevel)
```

**Addons Using This Function:**
- **WeakAuras**: Utilizes this function to display the power level of Azerite items in custom auras and notifications.
- **Pawn**: Uses this function to calculate and suggest upgrades for Azerite gear based on the power level.