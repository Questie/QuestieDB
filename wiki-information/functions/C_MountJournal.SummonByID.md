## Title: C_MountJournal.SummonByID

**Content:**
Summons the specified mount.
`C_MountJournal.SummonByID(mountID)`

**Parameters:**
- `mountID`
  - *number* : MountID - Valid mount IDs are returned from `C_MountJournal.GetMountIDs()`, or 0 to summon a random favorite mount appropriate to the current area.

**Reference:**
- `UNIT_SPELLCAST_SENT`, when the player begins casting the spell to summon the mount.
- `COMPANION_UPDATE`, after the spellcast completes, but at this time `IsMounted()` does not yet return true.
- See also: `C_MountJournal.Dismiss`.

**Description:**
If the specified index is out of range, nothing happens.
If the player has not yet collected the specified mount, no mount is summoned, and an error message is displayed in the center of the player's screen. The text of the error message is contained in the global variable `MOUNT_JOURNAL_NOT_COLLECTED`; in English clients, it is "You have not collected this mount."
If the specified index is 0, but the player has not marked any mounts as favorites, or does not have any favorite mounts that are appropriate for the current area, the error message "You have no valid favorite mounts." (global variable `ERR_MOUNT_NO_FAVORITES`) is displayed.
If the player cannot fly in the current area, then "appropriate for the current area" only includes ground-only mounts; it does not include flying mounts which can also run on land.