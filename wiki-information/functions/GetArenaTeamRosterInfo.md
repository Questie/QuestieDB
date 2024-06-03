## Title: GetArenaTeamRosterInfo

**Content:**
Requests information regarding the arena team that the player is in, see Returns for a full list of what this returns.
`name, rank, level, class, online, played, win, seasonPlayed, seasonWin, personalRating = GetArenaTeamRosterInfo(teamindex, playerid)`

**Parameters:**
- `teamindex`
  - *number* - Index of the team you want information on, can be a value between 1 and 3.
- `playerindex`
  - *number* - Index of the team member. Starts at 1.

**Returns:**
- `name`
  - *string* - Name of the player.
- `rank`
  - *number* - 0 denotes team captain, while 1 denotes a regular member.
- `level`
  - *number* - Player level.
- `class`
  - *string* - The localized class of the player.
- `online`
  - *number* - 1 denotes the player being online. nil denotes the player as offline.
- `played`
  - *number* - Number of games this player has played this week.
- `win`
  - *number* - Number of games this player has won this week.
- `seasonPlayed`
  - *number* - Number of games played the entire season.
- `seasonWin`
  - *number* - Number of games this player has won this week.
- `personalRating`
  - *number* - Player's personal rating with this team.