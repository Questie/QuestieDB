## Title: IsAddOnLoaded

**Content:**
Returns true if the specified addon is loaded.
`loaded, finished = IsAddOnLoaded(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `loaded`
  - *boolean* - True if the addon has been, or is being loaded.
- `finished`
  - *boolean* - True if the addon has finished loading and ADDON_LOADED has been fired for this addon.