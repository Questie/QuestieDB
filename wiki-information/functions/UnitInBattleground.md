## Title: UnitInBattleground

**Content:**
Returns the unit index if the unit is in your battleground.
`position = UnitInBattleground(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `position`
  - *number* - The position in the battleground raid of the specified unit, `nil` if outside of the battleground, and 0 if `unit` is `player` and player is the last person left standing inside of a finished battleground.

**Usage:**
```lua
local position = UnitInBattleground("player");
ChatFrame1:AddMessage('Position in battleground raid: ' .. (position or "(?)"));
```

**Miscellaneous:**
Result:

Prints the player's position number in the battleground raid. e.g. (depending on number left in battleground raid when call is made)
- Position in battleground raid: (?)
- Position in battleground raid: 0
- Position in battleground raid: 12

**Description:**
- Returns `nil` if outside of a battleground.
- Returns `0` if you are the last person inside of a battleground after the match is over, and everybody else has left.
- Returns 1-#, where # is the maximum number of players allowed in the battleground raid.