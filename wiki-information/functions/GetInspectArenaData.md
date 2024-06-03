## Title: GetInspectArenaData

**Content:**
Returns the inspected unit's rated PvP stats.
`rating, seasonPlayed, seasonWon, weeklyPlayed, weeklyWon = GetInspectArenaData(bracketId)`

**Parameters:**
- `bracketId`
  - *number* - rated PvP bracket to query, ascending from 1 for 2v2, 3v3, and 5v5 arenas, and Rated Battlegrounds respectively.

**Returns:**
- `rating`
  - *number* - inspected unit's current personal rating in the specified bracket.
- `seasonPlayed`
  - *number* - number of games played in the bracket during the current season.
- `seasonWon`
  - *number* - number of games won in the bracket during the current season.
- `weeklyPlayed`
  - *number* - number of games played in the bracket during the current week.
- `weeklyWon`
  - *number* - number of games won in the bracket during the current week.

**Description:**
Information is available when the `INSPECT_HONOR_UPDATE` event fires, or when `HasInspectHonorData` returns true.
You must request information from the server by calling `RequestInspectHonorData`.