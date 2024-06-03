## Event: UNIT_DAMAGE

**Title:** UNIT DAMAGE

**Content:**
Fired when the units melee damage changes.
`UNIT_DAMAGE: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId

**Content Details:**
Be warned that this often gets fired multiple times, for example when you change weapons.