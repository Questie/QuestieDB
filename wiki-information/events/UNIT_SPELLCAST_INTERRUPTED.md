## Event: UNIT_SPELLCAST_INTERRUPTED

**Title:** UNIT SPELLCAST INTERRUPTED

**Content:**
Fired when a unit's spellcast is interrupted, including party/raid members or the player.
`UNIT_SPELLCAST_INTERRUPTED: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*