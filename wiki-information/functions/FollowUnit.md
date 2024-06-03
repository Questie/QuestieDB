## Title: FollowUnit

**Content:**
Follows a friendly player unit.
`FollowUnit(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to follow.

**Description:**
You can stop follow by following the player itself: `FollowUnit("player")`. This can have side effects if the character is in a vehicle.
It is not possible to stop following someone from a script. The player needs to take action (move, jump, sit, whatever). See the Discussion page.
For historical reference, see also `FollowByName()`, which has been removed from the API.