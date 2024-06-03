## Title: UnitIsTrivial

**Content:**
Returns true if the unit is trivial (i.e. "grey" to the player).
`isTrivial = UnitIsTrivial(unit)`

**Parameters:**
- `unit`
  - *string* - UnitToken

**Returns:**
- `isTrivial`
  - *boolean* - True if the unit is comparatively too low level to provide experience or honor; otherwise false.

**Description:**
At level 60, units level 47 and under are trivial. 
Trivial units continue to give loot, quest credit, and (reduced) faction rep.