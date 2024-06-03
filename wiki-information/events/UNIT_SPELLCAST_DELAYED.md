## Event: UNIT_SPELLCAST_DELAYED

**Title:** UNIT SPELLCAST DELAYED

**Content:**
Fired when a unit's spellcast is delayed, including party/raid members or the player.
`UNIT_SPELLCAST_DELAYED: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*