## Title: GuildControlSaveRank

**Content:**
Saves the current rank name.
`GuildControlSaveRank(name)`

**Parameters:**
- `name`
  - *string* - the name of this rank

**Description:**
Saves the current flags, set using `GuildControlSetRankFlag()`, to the current rank.
Entering a name different from that of the rank set with `GuildControlSetRank()` will change the name of the current rank to the entered name.