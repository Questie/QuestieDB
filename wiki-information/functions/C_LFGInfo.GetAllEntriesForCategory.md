## Title: C_LFGInfo.GetAllEntriesForCategory

**Content:**
Returns any dungeons for a LFG category you're queued up for.
`lfgDungeonIDs = C_LFGInfo.GetAllEntriesForCategory(category)`

**Parameters:**
- `category`
  - *number*
  - *Enum*
    - `Value`
    - `Description`
    - `LE_LFG_CATEGORY_LFD`
      - *1* - Dungeon Finder
    - `LE_LFG_CATEGORY_LFR`
      - *2* - Other Raids
    - `LE_LFG_CATEGORY_RF`
      - *3* - Raid Finder
    - `LE_LFG_CATEGORY_SCENARIO`
      - *4* - Scenarios
    - `LE_LFG_CATEGORY_FLEXRAID`
      - *5* - Flexible Raid
    - `LE_LFG_CATEGORY_WORLDPVP`
      - *6* - Ashran
    - `LE_LFG_CATEGORY_BATTLEFIELD`
      - *7* - Brawl

**Returns:**
- `lfgDungeonIDs`
  - *number*