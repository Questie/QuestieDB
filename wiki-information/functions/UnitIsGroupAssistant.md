## Title: UnitIsGroupAssistant

**Content:**
Returns whether the unit is an assistant in your current group.
`isAssistant = UnitIsGroupAssistant(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId

**Returns:**
- `isAssistant`
  - *boolean* - true if the unit is a raid assistant in your current group, false otherwise.

**Description:**
Group leaders and assistants can invite players to the group, set main tanks, world markers, etc.
This function returns true only for players promoted to group assistants, either explicitly or via the "make everyone an assistant" option. It'll return false for the group leader.

**Reference:**
- `UnitIsGroupLeader`
- `IsEveryoneAssistant`