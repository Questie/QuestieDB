## Title: UnitHasLFGDeserter

**Content:**
Returns whether the unit is currently unable to use the dungeon finder due to leaving a group prematurely.
`isDeserter = UnitHasLFGDeserter(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - the unit that would assist (e.g., "player" or "target")

**Returns:**
- `isDeserter`
  - *boolean* - true if the unit is currently an LFG deserter (and hence unable to use the dungeon finder), false otherwise.