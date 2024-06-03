## Title: C_MountJournal.GetDisplayedMountID

**Content:**
Needs summary.
`mountID = C_MountJournal.GetDisplayedMountID(displayIndex)`

**Parameters:**
- `displayIndex`
  - *number*

**Returns:**
- `mountID`
  - *number*

**Example Usage:**
This function can be used to retrieve the mount ID of a mount displayed at a specific index in the Mount Journal. This is useful for addons that need to interact with or display information about mounts in the player's collection.

**Example:**
```lua
local displayIndex = 1
local mountID = C_MountJournal.GetDisplayedMountID(displayIndex)
print("The mount ID at display index 1 is:", mountID)
```

**Addons:**
Large addons like "MountJournalEnhanced" use this function to provide additional sorting and filtering options for mounts in the Mount Journal.