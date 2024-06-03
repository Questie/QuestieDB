## Title: GetInstanceLockTimeRemaining

**Content:**
Returns info for the instance lock timer for the current instance.
`lockTimeleft, isPreviousInstance, encountersTotal, encountersComplete = GetInstanceLockTimeRemaining()`

**Returns:**
- `lockTimeLeft`
  - *number* - Seconds until lock period ends.
- `isPreviousInstance`
  - *boolean* - Whether this instance has yet to be entered since last lockout expired (allowing for lock extension options).
- `encountersTotal`
  - *number* - Total number of bosses in the instance.
- `encountersComplete`
  - *number* - Number of bosses already dead in the instance.

**Description:**
On the continent of Pandaria, unlike other open world continents, `encountersTotal` is reported as 4. According to `GetInstanceLockTimeRemainingEncounter`, this corresponds with the first 4 Pandaria world bosses of the expansion - Galleon, Sha of Anger, Nalak, and Oondasta.
As of patch 5.4, the new world boss system isolates non-instance lockouts to `GetNumSavedWorldBosses` and `GetSavedWorldBossInfo`. It is likely that interacting with those bosses or their loot no longer has any effect on the old instance-based system represented by this function.

**Reference:**
- `GetInstanceLockTimeRemainingEncounter(...)` - drills down to specific boss
- `GetSavedInstanceInfo(...)` - newer, expanded version of this function