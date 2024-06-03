## Title: GetMaxLevelForExpansionLevel

**Content:**
Maps an expansion level to a maximum character level for that expansion.
`maxLevel = GetMaxLevelForExpansionLevel(expansionLevel)`

**Parameters:**
- `expansionLevel`
  - *number*
  - Values:
    - `Value`
    - `Enum`
    - `MaxLevel`
    - `0`
      - `LE_EXPANSION_CLASSIC`
      - `30`
    - `1`
      - `LE_EXPANSION_BURNING_CRUSADE`
      - `30`
    - `2`
      - `LE_EXPANSION_WRATH_OF_THE_LICH_KING`
      - `30`
    - `3`
      - `LE_EXPANSION_CATACLYSM`
      - `35`
    - `4`
      - `LE_EXPANSION_MISTS_OF_PANDARIA`
      - `35`
    - `5`
      - `LE_EXPANSION_WARLORDS_OF_DRAENOR`
      - `40`
    - `6`
      - `LE_EXPANSION_LEGION`
      - `45`
    - `7`
      - `LE_EXPANSION_BATTLE_FOR_AZEROTH`
      - `50`
    - `8`
      - `LE_EXPANSION_SHADOWLANDS`
      - `60`

**Returns:**
- `maxLevel`
  - *number*