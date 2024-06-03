## Title: C_AzeriteEmpoweredItem.GetPowerText

**Content:**
Needs summary.
`powerText = C_AzeriteEmpoweredItem.GetPowerText(azeriteEmpoweredItemLocation, powerID, level)`

**Parameters:**
- `azeriteEmpoweredItemLocation`
  - *ItemLocationMixin*
- `powerID`
  - *number*
- `level`
  - *Enum.AzeritePowerLevel*
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - Base
    - `1`
      - Upgraded
    - `2`
      - Downgraded

**Returns:**
- `powerText`
  - *structure* - AzeriteEmpoweredItemPowerText
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `description`
      - *string*