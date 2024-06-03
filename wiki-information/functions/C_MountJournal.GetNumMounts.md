## Title: C_MountJournal.GetNumMounts

**Content:**
Returns the number of mounts listed in the mount journal.
`numMounts = C_MountJournal.GetNumMounts()`

**Returns:**
- `numMounts`
  - *number*

**Description:**
Unlike the corresponding function for the pet journal, the number returned by this function includes not only the mounts that are currently visible in the mount journal, but also the mounts that are hidden by the player's current filter preferences, mounts that are hidden because they are not available to the player's faction, and mounts that are never displayed, such as the Swift Spectral Gryphon which players are mounted on while dead in certain zones.

**Reference:**
- `C_MountJournal.GetNumDisplayedMounts`