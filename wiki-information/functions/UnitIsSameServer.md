## Title: UnitIsSameServer

**Content:**
Returns true if the unit is from the same (connected) realm.
`sameServer = UnitIsSameServer(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId

**Returns:**
- `sameServer`
  - *boolean* - 1 if the specified unit is from the player's realm (or a Connected Realm linked to the player's own realm), nil otherwise.

**Reference:**
- `UnitRealmRelationship`