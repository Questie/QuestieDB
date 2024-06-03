## Title: C_MountJournal.GetMountFromSpell

**Content:**
Returns the mount for a spell ID.
`mountID = C_MountJournal.GetMountFromSpell(spellID)`

**Parameters:**
- `spellID`
  - *number*

**Returns:**
- `mountID`
  - *number?*

**Example Usage:**
This function can be used to retrieve the mount ID associated with a specific spell ID. This is particularly useful for addons that manage or display mount collections, allowing them to link spells to their corresponding mounts.

**Addon Usage:**
Large addons like "MountJournalEnhanced" or "CollectMe" might use this function to enhance the user interface for mount collections, providing additional information or functionality based on the mount ID retrieved from a spell ID.