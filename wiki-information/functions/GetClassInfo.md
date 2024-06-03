## Title: GetClassInfo

**Content:**
Returns information about a class.
`className, classFile, classID = GetClassInfo(classID)`

**Parameters:**
- `classID`
  - *number* : ClassId - Ranging from 1 to `GetNumClasses()`
  - Values:
    - `ID`
    - `className` (enUS)
    - `classFile`
    - `Description`
    - `1`
      - `Warrior`
      - `WARRIOR`
    - `2`
      - `Paladin`
      - `PALADIN`
    - `3`
      - `Hunter`
      - `HUNTER`
    - `4`
      - `Rogue`
      - `ROGUE`
    - `5`
      - `Priest`
      - `PRIEST`
    - `6`
      - `Death Knight`
      - `DEATHKNIGHT`
      - Added in 3.0.2
    - `7`
      - `Shaman`
      - `SHAMAN`
    - `8`
      - `Mage`
      - `MAGE`
    - `9`
      - `Warlock`
      - `WARLOCK`
    - `10`
      - `Monk`
      - `MONK`
      - Added in 5.0.4
    - `11`
      - `Druid`
      - `DRUID`
    - `12`
      - `Demon Hunter`
      - `DEMONHUNTER`
      - Added in 7.0.3
    - `13`
      - `Evoker`
      - `EVOKER`
      - Added in 10.0.0

**Returns:**
- `className`
  - *string* - Localized name, e.g. "Warrior" or "Guerrier".
- `classFile`
  - *string* - Locale-independent name, e.g. "WARRIOR".
- `classID`
  - *number* : ClassId

**Description:**
Returns nil for classes that don't exist in Classic.