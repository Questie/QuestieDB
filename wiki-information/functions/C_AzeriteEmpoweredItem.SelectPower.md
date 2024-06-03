## Title: C_AzeriteEmpoweredItem.SelectPower

**Content:**
Needs summary.
`success = C_AzeriteEmpoweredItem.SelectPower(azeriteEmpoweredItemLocation, powerID)`

**Parameters:**
- `azeriteEmpoweredItemLocation`
  - *ItemLocationMixin*
- `powerID`
  - *number*

**Returns:**
- `success`
  - *boolean*

**Example Usage:**
This function can be used to select a specific Azerite power for an Azerite item. For instance, if you have an Azerite item and you want to programmatically select a power based on certain conditions, you can use this function to do so.

**Addon Usage:**
Large addons like AzeritePowerWeights use this function to allow players to automatically select the best Azerite powers based on predefined weights and criteria. This helps in optimizing the character's performance without manually selecting each power.