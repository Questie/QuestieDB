## Event: UNIT_POWER_UPDATE

**Title:** UNIT POWER UPDATE

**Content:**
Fired when a unit's current power (mana, rage, focus, energy, runic power, holy power, ...) changes. See below for details.
`UNIT_POWER_UPDATE: unitTarget, powerType`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `powerType`
  - *string* - resource whose value changed: "MANA", "RAGE", "ENERGY", "FOCUS", "HAPPINESS", "RUNIC_POWER", "HOLY_POWER".

**Content Details:**
This event is fired under the following conditions:
- A spell is cast which changes the unit's power.
- The unit reaches full power.
- While the unit's power is naturally regenerating or decaying, this event will only fire once every two seconds. See UNIT_POWER_FREQUENT for a more exact alternative.
Related API
- UnitPower
Related Events
- UNIT_POWER_FREQUENT
Related Enum
- Enum.PowerType