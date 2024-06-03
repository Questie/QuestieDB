## Title: GuildControlDelRank

**Content:**
Deletes a guild rank.
`GuildControlDelRank(index)`

**Parameters:**
- `index`
  - *number* - must be between 1 and the value returned by `GuildControlGetNumRanks()`.

**Returns:**
- `nil`
  - If the rank cannot be deleted, a message will be sent to the default chat window.

**Description:**
The index rank must be unused - no guild members may currently have that rank or any lower rank (having a higher index value).