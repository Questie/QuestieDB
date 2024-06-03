## Event: UNIT_SPELLCAST_SUCCEEDED

**Title:** UNIT SPELLCAST SUCCEEDED

**Content:**
Fired when a spell is cast successfully. Event is received even if spell is resisted.
`UNIT_SPELLCAST_SUCCEEDED: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*