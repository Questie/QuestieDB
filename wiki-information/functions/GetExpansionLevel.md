## Title: GetExpansionLevel

**Content:**
Returns the expansion level currently accessible by the player.
`expansionLevel = GetExpansionLevel()`

**Returns:**
- `expansionLevel`
  - *number* - The newest expansion currently accessible by the player.
    - `NUM_LE_EXPANSION_LEVELS`
    - `Value`
    - `Enum`
    - `Description`
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
      - The War Within

**Description:**
Trial/Starter accounts are automatically upgraded to the second to last expansion.
Updated after `UPDATE_EXPANSION_LEVEL` fires.

**Usage:**
Before and after the Shadowlands global launch on November 23, 2020, at 3:00 p.m. PST. Requires the player to have pre-ordered/purchased the expansion.
```lua
/dump GetExpansionLevel() -- 7 -> 8
/dump GetAccountExpansionLevel() -- 8
/dump GetServerExpansionLevel() -- 7 -> 8
```
This API is equivalent to:
```lua
GetExpansionLevel() == min(GetAccountExpansionLevel(), GetServerExpansionLevel())
```