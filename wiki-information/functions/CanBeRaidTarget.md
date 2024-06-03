## Title: CanBeRaidTarget

**Content:**
Returns true if the unit can be marked with a raid target icon.
`canBeRaidTarget = CanBeRaidTarget(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `canBeRaidTarget`
  - *boolean* - true if raid target markers can be assigned to the queried unit, false otherwise.

**Reference:**
- `SetRaidTarget`

**Example Usage:**
This function can be used in a raid addon to determine if a specific unit can be marked with a raid target icon. For instance, in a boss encounter, you might want to mark certain adds or players with specific icons for better coordination.

**Addons Using This Function:**
Many raid management addons, such as Deadly Boss Mods (DBM) and BigWigs, use this function to automate the marking of units during encounters. This helps raid leaders quickly assign targets without manual intervention.