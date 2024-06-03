## Title: ArenaTeamDisband

**Content:**
Disbands an Arena Team if the player is the team captain.
`ArenaTeamDisband(index)`

**Parameters:**
- `index`
  - *number* - Index of the arena team to delete, index can be a value of 1 through 3.

**Usage:**
The following macro disbands the first arena team.
```lua
/run ArenaTeamDisband(1)
```
It can be used as the last solution to get rid of an arena team if all the other members of it don't come online anymore or if you just want to delete it. So far there is no UI implementation of this.