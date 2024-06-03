## Event: RAID_INSTANCE_WELCOME

**Title:** RAID INSTANCE WELCOME

**Content:**
Fired when the player enters an instance that saves raid members after a boss is killed.
`RAID_INSTANCE_WELCOME: mapname, timeLeft, locked, extended`

**Payload:**
- `mapname`
  - *string* - instance name
- `timeLeft`
  - *number* - seconds until reset
- `locked`
  - *number*
- `extended`
  - *number*