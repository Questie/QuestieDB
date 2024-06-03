## Title: C_MountJournal.IsTypeChecked

**Content:**
Needs summary.
`isChecked = C_MountJournal.IsTypeChecked(filterIndex)`

**Parameters:**
- `filterIndex`
  - *number*

**Returns:**
- `isChecked`
  - *boolean*

**Example Usage:**
This function can be used to check if a specific mount type filter is currently active in the Mount Journal. For instance, if you want to check if the "Flying" mount filter is enabled, you would use the corresponding filter index for flying mounts.

**Addons Usage:**
Large addons like "MountsJournal" or "CollectMe" might use this function to determine which mount types are currently being filtered by the user, allowing them to display or hide mounts accordingly.