## Title: GetBattlefieldStatus

**Content:**
Returns the status of the battlefield the player is either queued for or inside.
`status, mapName, teamSize, registeredMatch, suspendedQueue, queueType, gameType, role, asGroup, shortDescription, longDescription = GetBattlefieldStatus(index)`

**Parameters:**
- `index`
  - *number* - Index of the battlefield you wish to view, in the range of 1 to GetMaxBattlefieldID()

**Returns:**
- `status`
  - *string* - Battlefield status, one of:
    - `queued` - Waiting for a battlefield to become ready, you're in the queue
    - `confirm` - Ready to join a battlefield
    - `active` - Inside an active battlefield
    - `none` - Not queued for anything in this index
    - `error` - This should never happen
- `mapName`
  - *string* - Localized name of the battlefield (e.g., Warsong Gulch or Blade's Edge Arena)
- `teamSize`
  - *number* - Team size of the battlefield's queue (2, 3, or 5 in an arena queue, or 0 in other queue types)
- `registeredMatch`
  - *number* - 1 in a registered arena queue, or 0 in a skirmish or non-arena queue; use teamSize to check for arenas.
- `suspendedQueue`
  - *unknown* - (used to determine whether the eye icon on the LFG minimap button should animate, presumed boolean or 1/nil)
- `queueType`
  - *string* - The type of battleground, one of:
    - `ARENA`
    - `BATTLEGROUND`
    - `WARGAME`
- `gameType`
  - *string* - ??? (displayed as-is to the user on the queue ready dialog, so presumed localized; can be an empty string)
- `role`
  - *string* - The role assigned to the player (TANK, DAMAGER, HEALER) in a non-rated battleground, or nil for other queue types.
- `asGroup`
  - *unknown*
- `shortDescription`
  - *string*
- `longDescription`
  - *string*

**Example Usage:**
This function can be used to check the status of a player's queue for battlegrounds or arenas. For instance, an addon could use this to display the current queue status and estimated wait time for the player.

**Addons Using This Function:**
- **DBM (Deadly Boss Mods):** Uses this function to provide alerts and status updates for players queued for battlegrounds or arenas.
- **BattlegroundTargets:** Utilizes this function to display detailed information about the player's current battleground queue status and team composition.