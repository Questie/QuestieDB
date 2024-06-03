## Title: C_MountJournal.GetMountFromItem

**Content:**
Returns the mount for an item ID.
`mountID = C_MountJournal.GetMountFromItem(itemID)`

**Parameters:**
- `itemID`
  - *number*

**Returns:**
- `mountID`
  - *number?*

**Example Usage:**
This function can be used to determine which mount is associated with a specific item ID. For instance, if you have an item that you suspect grants a mount, you can use this function to confirm the mount ID.

**Addons Usage:**
Large addons like "AllTheThings" use this function to track and catalog mounts associated with items, helping players to complete their mount collections.