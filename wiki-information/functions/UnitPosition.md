## Title: UnitPosition

**Content:**
Returns the position of a unit in the current world area.
`positionX, positionY, positionZ, mapID = UnitPosition(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit for which the position is returned. Does not work with all unit types. Works with "player", "partyN" or "raidN" as unit type. In particular, it does not work on pets or any unit not in your group.

**Returns:**
- `positionX`
  - *number* - Y value of the unit's position in yards, relative to the instance
- `positionY`
  - *number* - X value of the unit's position in yards, relative to the instance
- `positionZ`
  - *number* - Always 0. A placeholder for the Z coordinate
- `mapID`
  - *number* : InstanceID

**Usage:**
Returns the distance in yards between 2 units in the same raid, or nil if they're not in the same instance or are in a raid/dungeon/competitive instance.
```lua
function ComputeDistance(unit1, unit2)
  local y1, x1, _, instance1 = UnitPosition(unit1)
  local y2, x2, _, instance2 = UnitPosition(unit2)
  return instance1 == instance2 and ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end
```
It's important to note that since this number is being measured from the center of the two units, and spell ranges are calculated from the edge of their hitbox, you will need to subtract 3 yards if you're using this function for measuring spell distance between players.