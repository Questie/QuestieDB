## Title: C_AddOns.GetAddOnOptionalDependencies

**Content:**
Returns a list of optional TOC dependencies.
`dep1, ... = C_AddOns.GetAddOnOptionalDependencies(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to `C_AddOns.GetNumAddOns`. The state of Blizzard addons can only be queried by name.

**Returns:**
- `dep1, ...`
  - *string?* - A list of addon names that are an optional dependency.