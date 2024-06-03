## Title: UnitRealmRelationship

**Content:**
Returns information about the player's relation to the specified unit's realm.
`realmRelationship = UnitRealmRelationship(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `realmRelationship`
  - *number* - if the specified unit is a player, one of:
    - `LE_REALM_RELATION_SAME = 1` - unit and player are from the same realm.
    - `LE_REALM_RELATION_COALESCED = 2` - unit and player are coalesced from unconnected realms.
    - `LE_REALM_RELATION_VIRTUAL = 3` - unit and player are from Connected Realms.

**Reference:**
`UnitName`