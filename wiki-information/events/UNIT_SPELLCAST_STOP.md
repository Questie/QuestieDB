## Event: UNIT_SPELLCAST_STOP

**Title:** UNIT SPELLCAST STOP

**Content:**
Fired when a unit stops casting, including party/raid members or the player.
`UNIT_SPELLCAST_STOP: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*