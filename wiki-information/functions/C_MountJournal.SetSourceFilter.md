## Title: C_MountJournal.SetSourceFilter

**Content:**
Needs summary.
`C_MountJournal.SetSourceFilter(filterIndex, isChecked)`

**Parameters:**
- `filterIndex`
  - *number*
- `isChecked`
  - *boolean*

**Description:**
This function is used to set the source filter for the Mount Journal. The `filterIndex` parameter specifies which filter to set, and the `isChecked` parameter specifies whether the filter should be enabled or disabled.

**Example Usage:**
```lua
-- Enable the filter for mounts obtained from achievements
C_MountJournal.SetSourceFilter(1, true)

-- Disable the filter for mounts obtained from vendors
C_MountJournal.SetSourceFilter(2, false)
```

**Additional Information:**
This function is commonly used in addons that manage or enhance the Mount Journal, such as MountFarmHelper or MountJournalEnhanced. These addons use this function to allow users to quickly filter and find specific mounts based on their source.