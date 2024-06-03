## Title: GetWatchedFactionInfo

**Content:**
Returns info for the currently watched faction.
`name, standing, min, max, value, factionID = GetWatchedFactionInfo()`

**Returns:**
- `name`
  - *string* - The name of the faction currently being watched, nil if no faction is being watched.
- `standing`
  - *number* - The StandingId with the faction.
- `min`
  - *number* - The minimum bound for the current standing, for instance 21000 for Revered.
- `max`
  - *number* - The maximum bound for the current standing, for instance 42000 for Revered.
- `value`
  - *number* - The current faction level, within the bounds.
- `factionID`
  - *number* (FactionID) - Unique numeric identifier for the faction.