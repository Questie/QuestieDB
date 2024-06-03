## Event: UNIT_MAXPOWER

**Title:** UNIT MAXPOWER

**Content:**
Fired when a unit's maximum power (mana, rage, focus, energy, runic power, ...) changes.
`UNIT_MAXPOWER: unitTarget, powerType`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `powerType`
  - *string* - resource whose maximum value changed: "MANA", "RAGE", "ENERGY", "FOCUS", "HAPPINESS", "RUNIC_POWER".