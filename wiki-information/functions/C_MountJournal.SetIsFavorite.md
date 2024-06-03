## Title: C_MountJournal.SetIsFavorite

**Content:**
Marks or unmarks the specified mount as a favorite.
`C_MountJournal.SetIsFavorite(mountIndex, isFavorite)`

**Parameters:**
- `mountIndex`
  - *number* - Index of the mount, in the range of 1 to `C_MountJournal.GetNumMounts()` (inclusive)
- `isFavorite`
  - *boolean*

**Description:**
Does nothing if the specified index is out of range.