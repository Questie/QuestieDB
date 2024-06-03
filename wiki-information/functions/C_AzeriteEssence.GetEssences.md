## Title: C_AzeriteEssence.GetEssences

**Content:**
Needs summary.
`essences = C_AzeriteEssence.GetEssences()`

**Returns:**
- `essences`
  - *structure* - AzeriteEssenceInfo
    - `AzeriteEssenceInfo`
      - `Field`
      - `Type`
      - `Description`
      - `ID`
        - *number*
      - `name`
        - *string*
      - `rank`
        - *number*
      - `unlocked`
        - *boolean*
      - `valid`
        - *boolean*
      - `icon`
        - *number*

**Example Usage:**
This function can be used to retrieve information about all the Azerite Essences a player has. For instance, an addon could use this to display a list of all available essences along with their ranks and icons.

**Addons:**
Many popular addons like WeakAuras and AzeritePowerWeights use this function to provide players with detailed information about their Azerite Essences, helping them make informed decisions about which essences to equip.