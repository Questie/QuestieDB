## Title: GetClientDisplayExpansionLevel

**Content:**
Returns the expansion level of the game client.
`expansionLevel = GetClientDisplayExpansionLevel()`

**Returns:**
- `expansionLevel`
  - *number*
  - `NUM_LE_EXPANSION_LEVELS`
    - **Value**
    - **Enum**
    - **Description**
    - `LE_EXPANSION_LEVEL_CURRENT`
      - 0
      - `LE_EXPANSION_CLASSIC`
      - Vanilla / Classic Era
    - 1
      - `LE_EXPANSION_BURNING_CRUSADE`
      - The Burning Crusade
    - 2
      - `LE_EXPANSION_WRATH_OF_THE_LICH_KING`
      - Wrath of the Lich King
    - 3
      - `LE_EXPANSION_CATACLYSM`
      - Cataclysm
    - 4
      - `LE_EXPANSION_MISTS_OF_PANDARIA`
      - Mists of Pandaria
    - 5
      - `LE_EXPANSION_WARLORDS_OF_DRAENOR`
      - Warlords of Draenor
    - 6
      - `LE_EXPANSION_LEGION`
      - Legion
    - 7
      - `LE_EXPANSION_BATTLE_FOR_AZEROTH`
      - Battle for Azeroth
    - 8
      - `LE_EXPANSION_SHADOWLANDS`
      - Shadowlands
    - 9
      - `LE_EXPANSION_DRAGONFLIGHT`
      - Dragonflight
    - 10
      - `LE_EXPANSION_11_0`

**Usage:**
Before and after updating to the 9.0.1 pre-patch.
`/dump GetClientDisplayExpansionLevel() -- 7 -> 8`