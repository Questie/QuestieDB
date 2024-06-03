## Title: GetLFGDungeonRewardCapBarInfo

**Content:**
Returns the weekly limits reward for a currency (e.g. Valor Point Cap).
`VALOR_TIER1_LFG_ID = 301`
`currencyID, DungeonID, Quantity, Limit, overallQuantity, overallLimit, periodPurseQuantity, periodPurseLimit, purseQuantity, purseLimit = GetLFGDungeonRewardCapBarInfo(VALOR_TIER1_LFG_ID)`

**Parameters:**
- `VALOR_TIER1_LFG_ID`
  - *Number* - ID of the dungeon type for which information is being sought (currently 301)

**Returns:**
- `currencyID`
  - *number* - ID for the currency
- `DungeonID`
  - *number* - ID for the dungeon type
- `Quantity`
  - *number* - Quantity gained from basic dungeons
- `Limit`
  - *number* - Limit gained from basic dungeons
- `overallQuantity`
  - *number* - Quantity gained from high-end dungeons (Zandalari)
- `overallLimit`
  - *number* - Limit gained from high-end dungeons (Zandalari)
- `periodPurseQuantity`
  - *number* - Quantity gained from all sources (raids)
- `periodPurseLimit`
  - *number* - Limit gained from all sources (raids)
- `purseQuantity`
  - *number* - Currently possessed amount
- `purseLimit`
  - *number* - Limit for possessed amount