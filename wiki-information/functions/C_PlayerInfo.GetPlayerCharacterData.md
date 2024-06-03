## Title: C_PlayerInfo.GetPlayerCharacterData

**Content:**
Needs summary.
`characterData = C_PlayerInfo.GetPlayerCharacterData()`

**Returns:**
- `characterData`
  - *PlayerInfoCharacterData*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `fileName`
      - *string*
    - `alternateFormRaceData`
      - *CharacterAlternateFormData?*
    - `createScreenIconAtlas`
      - *string*
    - `sex`
      - *Enum.UnitSex*

**CharacterAlternateFormData**
- `Field`
- `Type`
- `Description`
- `raceID`
  - *number*
- `name`
  - *string*
- `fileName`
  - *string*
- `createScreenIconAtlas`
  - *string*

**Enum.UnitSex**
- `Value`
- `Field`
- `Description`
- `0`
  - Male
- `1`
  - Female
- `2`
  - None
- `3`
  - Both
- `4`
  - Neutral