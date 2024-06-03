## Title: C_AddOns.IsAddOnLoaded

**Content:**
Needs summary.
`loadedOrLoading, loaded = C_AddOns.IsAddOnLoaded(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to C_AddOns.GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `loadedOrLoading`
  - *boolean*
- `loaded`
  - *boolean*