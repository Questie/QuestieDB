## Title: UnitHasLFGRandomCooldown

**Content:**
Returns whether the unit is currently under the effects of the random dungeon cooldown.
`hasRandomCooldown = UnitHasLFGRandomCooldown(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - the unit that would assist (e.g., "player" or "target")

**Returns:**
- `hasRandomCooldown`
  - *boolean* - true if the unit is currently unable to queue for random dungeons due to the random cooldown, false otherwise.

**Description:**
Players may also be prevented from using the dungeon finder entirely, as part of the dungeon finder deserter effect. Use `UnitHasLFGDeserter("unit")` to query that.