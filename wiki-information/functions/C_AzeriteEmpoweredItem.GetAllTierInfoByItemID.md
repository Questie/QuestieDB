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
  - *number|string* - Item ID, Link, or Name
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