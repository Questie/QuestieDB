## Title: UnitInAnyGroup

**Content:**
Returns whether or not the targeted unit is in a Group of any type. Instance, raid, party, etc.
`inGroup = UnitInAnyGroup(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit token of the unit to check group status for. Always returns false if no unit is provided.

**Returns:**
- `inGroup`
  - *boolean* - True if the target is in a group, false otherwise.