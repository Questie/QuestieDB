## Title: GetArenaTeamIndexBySize

**Content:**
Returns the index of an arena team for the specified team size.
`index = GetArenaTeamIndexBySize(size)`

**Parameters:**
- `size`
  - *number* - team size (number of people), i.e. 2, 3, or 5.

**Returns:**
- `index`
  - *number* - arena team index for the specified team size, or nil if the player is not in a team of the specified size.

**Description:**
Arena team indices typically correspond to their creation/join order, and may be discontinuous.
You can get information about a given team from its index using `GetArenaTeam`.