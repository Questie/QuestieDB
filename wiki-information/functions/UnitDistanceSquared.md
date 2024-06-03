## Title: UnitDistanceSquared

**Content:**
Returns the squared distance to a unit in your group.
`distanceSquared, checkedDistance = UnitDistanceSquared(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit id of a player in your group.

**Returns:**
- `distanceSquared`
  - *number* - the squared distance to that unit
- `checkedDistance`
  - *boolean* - true if the distance result is valid, false otherwise (e.g., unit not found or not in your group)

**Example Usage:**
This function can be used in scenarios where you need to determine the distance between players in a group, such as in raid addons to check if players are within a certain range for buffs or abilities.

**Addons Using This Function:**
- **Deadly Boss Mods (DBM):** Uses this function to determine if players are within range of each other for certain boss mechanics.
- **WeakAuras:** Can use this function to create custom auras that trigger based on the distance between group members.