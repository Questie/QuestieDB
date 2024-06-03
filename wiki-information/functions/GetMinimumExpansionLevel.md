## Title: GetMinimumExpansionLevel

**Content:**
Needs summary.
`expansionLevel = GetMinimumExpansionLevel()`

**Returns:**
- `expansionLevel`
  - *number* - Corresponds to the expansion level constants:
    - `Value`
    - `Enum`
    - `Description`
    - `LE_EXPANSION_LEVEL_CURRENT`
      - *0* - LE_EXPANSION_CLASSIC
      - *Vanilla / Classic Era*
    - `1`
      - *LE_EXPANSION_BURNING_CRUSADE*
      - *The Burning Crusade*
    - `2`
      - *LE_EXPANSION_WRATH_OF_THE_LICH_KING*
      - *Wrath of the Lich King*
    - `3`
      - *LE_EXPANSION_CATACLYSM*
      - *Cataclysm*
    - `4`
      - *LE_EXPANSION_MISTS_OF_PANDARIA*
      - *Mists of Pandaria*
    - `5`
      - *LE_EXPANSION_WARLORDS_OF_DRAENOR*
      - *Warlords of Draenor*
    - `6`
      - *LE_EXPANSION_LEGION*
      - *Legion*
    - `7`
      - *LE_EXPANSION_BATTLE_FOR_AZEROTH*
      - *Battle for Azeroth*
    - `8`
      - *LE_EXPANSION_SHADOWLANDS*
      - *Shadowlands*
    - `9`
      - *LE_EXPANSION_DRAGONFLIGHT*
      - *Dragonflight*
    - `10`
      - *LE_EXPANSION_11_0*

**Example Usage:**
This function can be used to determine the minimum expansion level required for certain features or content in the game. For instance, if a developer wants to check if a player has access to content from a specific expansion, they can use this function to get the minimum expansion level and compare it with the required expansion level for that content.

**Addons Usage:**
Large addons like "WeakAuras" might use this function to ensure compatibility with different expansions by checking the minimum expansion level and adjusting their features accordingly. This helps in providing a seamless experience for users across various expansions.