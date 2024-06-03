## Title: C_AddOns.IsAddOnLoadable

**Content:**
Needs summary.
`loadable, reason = C_AddOns.IsAddOnLoadable(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to `C_AddOns.GetNumAddOns`. The state of Blizzard addons can only be queried by name.
- `character`
  - *string?* - The name of the character to check against, or omitted/nil for all characters.
- `demandLoaded`
  - *boolean?* = false

**Returns:**
- `loadable`
  - *boolean*
- `reason`
  - *string*