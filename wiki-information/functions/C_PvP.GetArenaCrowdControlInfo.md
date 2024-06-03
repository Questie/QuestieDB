## Title: C_PvP.GetArenaCrowdControlInfo

**Content:**
Needs summary.
`spellID, startTime, duration = C_PvP.GetArenaCrowdControlInfo(playerToken)`

**Parameters:**
- `playerToken`
  - *string*

**Returns:**
- `spellID`
  - *number*
- `startTime`
  - *number*
- `duration`
  - *number*

**Example Usage:**
This function can be used to get information about crowd control effects on a player in an arena match. For instance, an addon could use this to display a timer for how long a player will be affected by a crowd control spell.

**Addon Usage:**
- **Gladius**: This popular PvP addon uses `C_PvP.GetArenaCrowdControlInfo` to track and display crowd control durations on enemy players in arena matches, helping players to better manage their cooldowns and crowd control strategies.