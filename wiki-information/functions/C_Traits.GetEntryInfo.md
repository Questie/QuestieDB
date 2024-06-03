## Title: C_Traits.GetEntryInfo

**Content:**
Needs summary.
`entryInfo = C_Traits.GetEntryInfo(configID, entryID)`

**Parameters:**
- `configID`
  - *number*
- `entryID`
  - *number*

**Returns:**
- `entryInfo`
  - *TraitEntryInfo*
    - `Field`
    - `Type`
    - `Description`
    - `definitionID`
      - *number*
    - `type`
      - *Enum.TraitNodeEntryType*
    - `maxRanks`
      - *number*
    - `isAvailable`
      - *boolean*
    - `conditionIDs`
      - *number*

**Enum.TraitNodeEntryType Values:**
- `Field`
- `Description`
- `0`
  - SpendHex
- `1`
  - SpendSquare
- `2`
  - SpendCircle
- `3`
  - SpendSmallCircle
- `4`
  - DeprecatedSelect
- `5`
  - DragAndDrop
- `6`
  - SpendDiamond
- `7`
  - ProfPath
- `8`
  - ProfPerk
- `9`
  - ProfPathUnlock