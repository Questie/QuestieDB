## Title: GetCompanionCooldown

**Content:**
Returns cooldown information about the companions you have.
`startTime, duration, isEnabled = GetCompanionCooldown("type", id)`

**Parameters:**
- `type`
  - *String (companionType)* - Type of the companion being queried ("CRITTER" or "MOUNT")
- `id`
  - *Number* - The slot id to query (starts at 1).

**Returns:**
- `start`
  - *Number* - the time the cooldown period began, based on GetTime().
- `duration`
  - *Number* - the duration of the cooldown period.
- `isEnabled`
  - *Number* - 1 if the companion has a cooldown.