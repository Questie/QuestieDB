## Title: ClosestUnitPosition

**Content:**
Returns the unit position of the closest creature by ID. Only works for mobs in the starting zones.
`xPos, yPos, distance = ClosestUnitPosition(creatureID)`

**Parameters:**
- `creatureID`
  - *number* - NPC ID of a GUID of a creature.

**Returns:**
- `xPos`
  - *number*
- `yPos`
  - *number*
- `distance`
  - *number* - Relative distance in yards.