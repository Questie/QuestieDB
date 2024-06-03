## Title: GetExpansionDisplayInfo

**Content:**
Returns the logo and banner textures for an expansion id.
`info = GetExpansionDisplayInfo(expansionLevel)`

**Parameters:**
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
    - `LE_EXPANSION_BURNING_CRUSADE`
      - The Burning Crusade
    - `LE_EXPANSION_WRATH_OF_THE_LICH_KING`
      - Wrath of the Lich King
    - `LE_EXPANSION_CATACLYSM`
      - Cataclysm
    - `LE_EXPANSION_MISTS_OF_PANDARIA`
      - Mists of Pandaria
    - `LE_EXPANSION_WARLORDS_OF_DRAENOR`
      - Warlords of Draenor
    - `LE_EXPANSION_LEGION`
      - Legion
    - `LE_EXPANSION_BATTLE_FOR_AZEROTH`
      - Battle for Azeroth
    - `LE_EXPANSION_SHADOWLANDS`
      - Shadowlands
    - `LE_EXPANSION_DRAGONFLIGHT`
      - Dragonflight
    - `LE_EXPANSION_11_0`

**Returns:**
- `info`
  - *ExpansionDisplayInfo?*
    - **Field**
    - **Type**
    - **Description**
    - `logo`
      - *number*
    - `banner`
      - *string*
    - `features`
      - *ExpansionDisplayInfoFeature*
    - `highResBackgroundID`
      - *number*
      - Added in 10.0.0
    - `lowResBackgroundID`
      - *number*
      - Added in 10.0.0

**ExpansionDisplayInfoFeature:**
- **Field**
- **Type**
- **Description**
- `icon`
  - *number*
- `text`
  - *string*