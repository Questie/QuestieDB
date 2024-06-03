## Event: UNIT_SPELLCAST_SENT

**Title:** UNIT SPELLCAST SENT

**Content:**
Fired when a unit attempts to cast a spell regardless of the success of the cast.
`UNIT_SPELLCAST_SENT: unit, target, castGUID, spellID`

**Payload:**
- `unit`
  - *string* : UnitId - Only fires for "player"
- `target`
  - *string* : UnitId
- `castGUID`
  - *string* : GUID - e.g. for (Spell ID 1543) "Cast-3-3783-1-7-1543-000197DD84"
- `spellID`
  - *number*

**Content Details:**
Fired when a unit tries to cast an instant, non-instant, or channeling spell even if out of range or out of line-of-sight (unless the unit is attempting to cast a non-instant spell while already casting or attempting to cast a spell that is on cooldown).