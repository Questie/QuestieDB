## Title: UnitHasIncomingResurrection

**Content:**
Returns true if the unit is currently being resurrected.
`isBeingResurrected = UnitHasIncomingResurrection(unitID or UnitName)`

**Parameters:**
- `unitID`
  - *string* - either the unitID ("player", "target", "party3", etc) or unit's name ("Bob" or "Bob-Llane")

**Returns:**
- `isBeingResurrected`
  - *boolean* - Returns true if the unit is being resurrected by any means, be it spell, item, or some other method. Returns nil/false otherwise.

**Description:**
This returns nil/false if the cast is completed and the unit has not yet accepted the resurrection. It is only true if the cast is in progress and the cast is some method of resurrection.