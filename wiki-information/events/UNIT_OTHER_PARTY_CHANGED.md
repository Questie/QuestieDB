## Event: UNIT_OTHER_PARTY_CHANGED

**Title:** UNIT OTHER PARTY CHANGED

**Content:**
Fired when a unit enter or leave an instance group while within a regular group.
Example¹: a unit doing dungeon finder, accepts an invite from a friend outside the instanced group.
Example²: the same unit leaves the instanced group and, is now in fact, inside the friend's group.
`UNIT_OTHER_PARTY_CHANGED: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId