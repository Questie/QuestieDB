## Title: C_LFGList.CreateListing

**Content:**
Creates a group finder listing.
`success = C_LFGList.CreateListing(activityID, itemLevel, honorLevel)`

**Parameters:**
- `activityID`
  - *number* : GroupFinderActivity.ID
- `itemLevel`
  - *number*
- `honorLevel`
  - *number*
- `autoAccept`
  - *boolean?*
- `privateGroup`
  - *boolean?*
- `questID`
  - *number?*

**Returns:**
- `success`
  - *boolean* - Generally returns true if there was a valid group title.

**Usage:**
Creates a group listing for "Custom PvE". Requires the title of the listing to have been typed manually, otherwise it silently fails. Setting the title is explicitly protected.
```lua
/run C_LFGList.CreateListing(16, 0, 0)
```