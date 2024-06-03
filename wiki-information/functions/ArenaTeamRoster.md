## Title: ArenaTeamRoster

**Content:**
Requests the arena team information from the server
`ArenaTeamRoster(index)`

**Parameters:**
- `index`
  - *number* - Index of the arena team to request information from, 1 through 3.

**Description:**
Because this sends a request to the server, you will not get the data instantly; you must register and watch for the `ARENA_TEAM_ROSTER_UPDATE` event.
It appears that `ARENA_TEAM_ROSTER_UPDATE` will not fire if you requested the same team index last call.