## Event: UNIT_COMBAT

**Title:** UNIT COMBAT

**Content:**
Fired when an npc or player participates in combat and takes damage
`UNIT_COMBAT: unitTarget, event, flagText, amount, schoolMask`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `event`
  - *string* - Action, Damage, etc (e.g. HEAL, DODGE, BLOCK, WOUND, MISS, PARRY, RESIST, ...)
- `flagText`
  - *string* - Critical/Glancing indicator (e.g. CRITICAL, CRUSHING, GLANCING)
- `amount`
  - *number* - The numeric damage
- `schoolMask`
  - *number* - Damage type in numeric value (1 - physical; 2 - holy; 4 - fire; 8 - nature; 16 - frost; 32 - shadow; 64 - arcane)