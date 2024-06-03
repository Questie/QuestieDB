## Title: C_AddOns.LoadAddOn

**Content:**
Needs summary.
`loaded, value = C_AddOns.LoadAddOn(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to `C_AddOns.GetNumAddOns`. The state of Blizzard addons can only be queried by name.

**Returns:**
- `loaded`
  - *boolean?* - true if the addon was loaded successfully, or if it has already been loaded.
- `value`
  - *string?* - Locale-independent reason why the addon could not be loaded e.g. "DISABLED", otherwise returns nil if the addon was loaded.

**Description:**
Calling this function inside an `ADDON_LOADED` event handler may result in the named addon never receiving its own `ADDON_LOADED` event, as any new registrations for the event do not take effect until the dispatch of the first event has completed.