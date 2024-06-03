## Event: UNIT_SPELLCAST_CHANNEL_START

**Title:** UNIT SPELLCAST CHANNEL START

**Content:**
Fired when a unit begins channeling in the course of casting a spell. Received for party/raid members as well as the player.
`UNIT_SPELLCAST_CHANNEL_START: unitTarget, castGUID, spellID`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `castGUID`
  - *string*
- `spellID`
  - *number*