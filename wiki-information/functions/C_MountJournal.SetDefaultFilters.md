## Title: C_MountJournal.SetDefaultFilters

**Content:**
Needs summary.
`C_MountJournal.SetDefaultFilters()`

**Description:**
This function resets the mount journal filters to their default state. This can be useful if you have applied multiple filters and want to quickly revert to the default view without manually unchecking each filter.

**Example Usage:**
```lua
-- Reset the mount journal filters to default
C_MountJournal.SetDefaultFilters()
```

**Use in Addons:**
Large addons like "MountsJournal" or "CollectMe" might use this function to ensure that the mount list is in a known state before applying their own custom filters or sorting logic.