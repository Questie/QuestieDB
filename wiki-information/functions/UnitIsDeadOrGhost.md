## Title: UnitIsDeadOrGhost

**Content:**
Returns true if the unit is dead or in ghost form.
`isDeadOrGhost = UnitIsDeadOrGhost(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `isDeadOrGhost`
  - *boolean*

**Description:**
Effectively combines UnitIsDead and UnitIsGhost, returning true if either of those functions would return true.
Does not work for despawned pet units. (A pet is "despawned" once its corpse is no longer targetable in the game world, or its action bar is no longer visible on its owner's screen.)
Returns false for priests who are currently in form, having died once and are about to die again.

**Reference:**
- `UnitIsDead`
- `UnitIsGhost`