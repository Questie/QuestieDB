## Title: C_LootHistory.GetItem

**Content:**
Returns item details for a loot event.
`rollID, itemLink, numPlayers, isDone, winnerIdx, isMasterLoot = C_LootHistory.GetItem(itemIdx)`

**Parameters:**
- `itemIdx`
  - *number* - Loot history ID

**Returns:**
- `rollID`
  - *number*
- `itemLink`
  - *string*
- `numPlayers`
  - *number* - Total players eligible for item
- `isDone`
  - *boolean*
- `winnerIdx`
  - *number* - See C_LootHistory.GetPlayerInfo
- `isMasterLoot`
  - *boolean*