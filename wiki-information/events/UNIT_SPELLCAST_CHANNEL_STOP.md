## Event: UNIT_SPELLCAST_CHANNEL_STOP

**Title:** UNIT SPELLCAST CHANNEL STOP

**Content:**
Fired when a unit stops channeling. Received for party/raid members as well as the player.
`UNIT_SPELLCAST_CHANNEL_STOP: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*