## Event: UNIT_SPELLCAST_START

**Title:** UNIT SPELLCAST START

**Content:**
Fired when a unit begins casting a non-instant cast spell, including party/raid members or the player.
`UNIT_SPELLCAST_START: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*