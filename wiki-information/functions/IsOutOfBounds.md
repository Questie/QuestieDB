## Title: IsOutOfBounds

**Content:**
Returns true if the player is currently outside of map boundaries.
`oob = IsOutOfBounds()`

**Returns:**
- `oob`
  - *boolean* - True if the player's character is currently outside of the map, false otherwise.

**Description:**
Players may end up outside of a map's bounds (and therefore dead) both as a consequence of geometry errors and normal world design: for instance, falling off the Eye of the Storm, or being dropped off the top of Icecrown Citadel by the Lich King's val'kyrs.