## Title: C_LootHistory.GetPlayerInfo

**Content:**
Returns player details for a loot event.
`name, class, rollType, roll, isWinner, isMe = C_LootHistory.GetPlayerInfo(itemIdx, playerIdx)`

**Parameters:**
- `itemIdx`
  - *number* - See `C_LootHistory.GetItem`

**Returns:**
- `name`
  - *string*
- `class`
  - *string*
- `rollType`
  - *number* - (0: pass, 1: need, 2: greed, 3: disenchant)
- `roll`
  - *number*
- `isWinner`
  - *boolean*
- `isMe`
  - *boolean*