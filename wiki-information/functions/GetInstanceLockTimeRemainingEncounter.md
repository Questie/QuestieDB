## Title: GetInstanceLockTimeRemainingEncounter

**Content:**
Returns information about bosses in the instance the player is about to be saved to.
`bossName, texture, isKilled = GetInstanceLockTimeRemainingEncounter(id)`

**Parameters:**
- `id`
  - *number* - Index of the boss to query, ascending from 1 to encountersTotal return value from GetInstanceLockTimeRemaining.

**Returns:**
- `bossName`
  - *string* - Name of the boss.
- `texture`
  - *string* - ?
- `isKilled`
  - *boolean* - true if the boss has been killed.

**Reference:**
- `GetInstanceLockTimeRemaining()` - zooms out to full instance's info
- `GetSavedWorldBossInfo(...)` - also provides boss info, but for world bosses