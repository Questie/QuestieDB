## Title: C_Commentator.GetPlayerFlagInfo

**Content:**
Needs summary.
`hasFlag = C_Commentator.GetPlayerFlagInfo(teamIndex, playerIndex)`

**Parameters:**
- `teamIndex`
  - *number*
- `playerIndex`
  - *number*

**Returns:**
- `hasFlag`
  - *boolean*

**Description:**
This function is used to determine if a player in a commentator's view has a flag. It is particularly useful in PvP scenarios, such as battlegrounds or arena matches, where tracking flag possession is crucial for commentary and analysis.

**Example Usage:**
In a custom addon designed for eSports commentary, this function can be used to highlight players who are currently carrying a flag, allowing commentators to provide more detailed and engaging play-by-play analysis.

**Addons Using This Function:**
- **Blizzard's Arena Spectator UI**: Utilizes this function to display flag status for players during arena matches, enhancing the viewing experience for spectators.