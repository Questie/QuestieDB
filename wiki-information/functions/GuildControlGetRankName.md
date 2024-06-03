## Title: GuildControlGetRankName

**Content:**
Returns a guild rank name by index.
`GuildControlGetRankName(index)`

**Parameters:**
- `index`
  - *number* - the rank index

**Returns:**
- `rankName`
  - *string* - the name of the rank at index.

**Description:**
`index` must be between 1 and `GuildControlGetNumRanks()`.