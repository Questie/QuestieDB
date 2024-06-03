## Title: GetPersonalRatedInfo

**Content:**
Returns information about the player's personal PvP rating in a specific bracket.
`rating, seasonBest, weeklyBest, seasonPlayed, seasonWon, weeklyPlayed, weeklyWon, cap = GetPersonalRatedInfo(index)`

**Parameters:**
- `index`
  - *number* - PvP bracket index ascending from 1 for 2v2, 3v3, 5v5, and 10v10 rated battlegrounds.

**Returns:**
- `rating`
  - *number* - the player's current rating.
- `seasonBest`
  - *number* - the player's season best rating.
- `weeklyBest`
  - *number* - the player's weekly best rating.
- `seasonPlayed`
  - *number* - number of games played in this bracket this season.
- `seasonWon`
  - *number* - number of games won in this bracket this season.
- `weeklyPlayed`
  - *number* - number of games played in this bracket this week.
- `weeklyWon`
  - *number* - number of games won in this bracket this season.
- `cap`
  - *number* - projected conquest cap in points.

**Reference:**
`GetInspectArenaData`

**Example Usage:**
This function can be used to display a player's current and historical performance in different PvP brackets. For instance, an addon that tracks and displays PvP statistics could use this function to show detailed information about a player's ratings and game history.

**Addon Usage:**
Large PvP-focused addons like "GladiatorlosSA" or "REFlex - Arena/Battleground Historian" might use this function to provide players with insights into their performance, helping them to track their progress and improve their strategies in rated PvP matches.