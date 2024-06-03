## Title: C_Commentator.GetPlayerCooldownInfo

**Content:**
Needs summary.
`startTime, duration, enable = C_Commentator.GetPlayerCooldownInfo(teamIndex, playerIndex, spellID)`

**Parameters:**
- `teamIndex`
  - *number*
- `playerIndex`
  - *number*
- `spellID`
  - *number*

**Returns:**
- `startTime`
  - *number*
- `duration`
  - *number*
- `enable`
  - *boolean*

**Description:**
This function retrieves cooldown information for a specific player's spell in a commentator mode match. It can be used to track the cooldown status of abilities during esports events or other competitive matches.

**Example Usage:**
An addon designed for commentators might use this function to display cooldown timers for players' abilities on the screen, providing viewers with real-time information about the availability of key spells.

**Addons:**
Large addons like "ArenaLive" or "Gladius" might use this function to enhance the spectator experience by showing detailed cooldown information for players in PvP matches.