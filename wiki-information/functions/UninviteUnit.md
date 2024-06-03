## Title: UninviteUnit

**Content:**
Removes a player from the group if you're the leader, or initiates a vote to kick.
`UninviteUnit(name)`

**Parameters:**
- `name`
  - *string* - Name of the player to remove from the group. When removing cross-server players, it is important to include the server name: "Ygramul-Emerald Dream".
- `reason`
  - *string?* - Used when initiating a kick vote against the player.

**Description:**
If you're in a Dungeon Finder group and call `UninviteUnit` without providing a reason, the `VOTE_KICK_REASON_NEEDED` event will fire to notify you that a reason is required to initiate a kick vote.