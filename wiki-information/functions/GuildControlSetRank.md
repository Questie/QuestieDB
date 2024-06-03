## Title: GuildControlSetRank

**Content:**
Selects a guild rank.
`GuildControlSetRank(rankOrder)`

**Parameters:**
- `rankOrder`
  - *number* - index of the rank to select, between 1 and `GuildControlGetNumRanks()`.

**Description:**
Calling this API sets the rank to return/edit flags for using `GuildControlGetRankFlags()` and `GuildControlSetRankFlag()`.