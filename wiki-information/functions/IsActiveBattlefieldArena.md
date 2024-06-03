## Title: IsActiveBattlefieldArena

**Content:**
Returns true if the player is inside a (rated) arena.
`isArena, isRegistered = IsActiveBattlefieldArena()`

**Returns:**
- `isArena`
  - *boolean* - If the player is inside an arena.
- `isRegistered`
  - *boolean* - If the player is playing a rated arena match.

**Description:**
If you are in the waiting room and/or countdown is going on, it will return false.