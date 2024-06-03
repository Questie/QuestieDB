## Title: C_CreatureInfo.GetRaceInfo

**Content:**
Returns both localized and locale-independent race names.
`raceInfo = C_CreatureInfo.GetRaceInfo(raceID)`

**Parameters:**
- `raceID`
  - *number*

**Returns:**
- `raceInfo`
  - *structure* - RaceInfo (nilable)
    - `Field`
    - `Type`
    - `Description`
    - `raceName`
      - *string* - localized name, e.g. "Night Elf"
    - `clientFileString`
      - *string* - non-localized name, e.g. "NightElf"
    - `raceID`
      - *number*

**Example Usage:**
This function can be used to retrieve race information for displaying in a user interface or for logging purposes. For instance, an addon that customizes character creation screens might use this function to fetch and display race names.

**Addon Usage:**
Large addons like "Altoholic" might use this function to display race information for characters across different realms and accounts.