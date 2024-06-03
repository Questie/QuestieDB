## Title: C_MountJournal.GetMountUsabilityByID

**Content:**
Returns if a mount is currently usable by the player.
`isUsable, useError = C_MountJournal.GetMountUsabilityByID(mountID, checkIndoors)`

**Parameters:**
- `mountID`
  - *number*
- `checkIndoors`
  - *boolean*

**Returns:**
- `isUsable`
  - *boolean*
- `useError`
  - *string?*

**Example Usage:**
This function can be used to check if a specific mount can be used in the current environment. For instance, you might want to check if a flying mount can be used indoors or if a specific mount is restricted in certain areas.

**Addon Usage:**
Large addons like "MountJournalEnhanced" use this function to provide users with detailed information about mount usability, including restrictions and error messages when attempting to use a mount in an inappropriate location.