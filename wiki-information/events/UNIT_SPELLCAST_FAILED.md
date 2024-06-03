## Event: UNIT_SPELLCAST_FAILED

**Title:** UNIT SPELLCAST FAILED

**Content:**
Fired when a unit's spellcast fails, including party/raid members or the player.
`UNIT_SPELLCAST_FAILED: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*