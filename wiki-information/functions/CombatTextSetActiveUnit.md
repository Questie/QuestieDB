## Title: CombatTextSetActiveUnit

**Content:**
Changes the entity for which COMBAT_TEXT_UPDATE events fire.
`CombatTextSetActiveUnit(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The entity you want to receive notifications for.

**Description:**
The event is tied to the entity rather than the unit -- thus, if you call `CombatTextSetActiveUnit("target")` and then target something else, you'll get notifications for the unit you were targeting when calling the function, rather than your new target.
Only one unit can be "active" at a time.
The `COMBAT_TEXT_UPDATE` event is used to provide part of Blizzard's Floating Combat Text functionality; it fires to notify of aura gains/losses and incoming damage and heals.

**Reference:**
- `COMBAT_TEXT_UPDATE`