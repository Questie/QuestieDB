## Title: C_MountJournal.GetIsFavorite

**Content:**
Indicates whether the specified mount is marked as a favorite.
`isFavorite, canSetFavorite = C_MountJournal.GetIsFavorite(mountIndex)`

**Parameters:**
- `mountIndex`
  - *number* - Index of the mount, in the range of 1 to `C_MountJournal.GetNumMounts()` (inclusive)

**Returns:**
- `isFavorite`
  - *boolean*
- `canSetFavorite`
  - *boolean*