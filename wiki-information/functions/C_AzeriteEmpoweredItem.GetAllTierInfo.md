## Title: C_AzeriteEmpoweredItem.GetAllTierInfo

**Content:**
Needs summary.
```lua
tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfo(azeriteEmpoweredItemLocation)
tierInfo = C_AzeriteEmpoweredItem.GetAllTierInfoByItemID(itemInfo)
```

**Parameters:**

*GetAllTierInfo:*
- `azeriteEmpoweredItemLocation`
  - *ItemLocationMixin*

*GetAllTierInfoByItemID:*
- `itemInfo`
  - *number|string* - Item ID, Link or Name
- `classID`
  - *number?* - Specify a class ID to get tier information about that class, otherwise uses the player's class if left nil

**Returns:**
- `tierInfo`
  - *structure* - AzeriteEmpoweredItemTierInfo
    - `Field`
    - `Type`
    - `Description`
    - `azeritePowerIDs`
      - *number*
    - `unlockLevel`
      - *number*

**Example Usage:**
This function can be used to retrieve information about all the tiers of Azerite powers available for a given Azerite item. This is particularly useful for addons that need to display or process Azerite power information.

**Addon Usage:**
Large addons like AzeritePowerWeights use this function to calculate and display the optimal Azerite traits for players based on their class and spec. This helps players make informed decisions about which Azerite traits to select for their gear.