## Event: UNIT_TARGET

**Title:** UNIT TARGET

**Content:**
Fired when the target of yourself, raid, and party members change
`UNIT_TARGET: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId

**Content Details:**
Should also work for 'pet' and 'focus'. This event only fires when the triggering unit is within the player's visual range.