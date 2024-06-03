## Event: UNIT_POWER_FREQUENT

**Title:** UNIT POWER FREQUENT

**Content:**
Fired when a unit's current power (mana, rage, focus, energy, runic power, holy power, ...) changes.
`UNIT_POWER_FREQUENT: unitTarget, powerType`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `powerType`
  - *string*

**Content Details:**
Unlike UNIT_POWER_UPDATE, this event will fire multiple times per frame while the unit's power is regenerating or decaying quickly.
Related API
UnitPower
Related Events
UNIT_POWER_UPDATE