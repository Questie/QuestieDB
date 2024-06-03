## Event: UNIT_SPELLCAST_CHANNEL_UPDATE

**Title:** UNIT SPELLCAST CHANNEL UPDATE

**Content:**
Fires while a unit is channeling. Received for party/raid members, as well as the player.
`UNIT_SPELLCAST_CHANNEL_UPDATE: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*