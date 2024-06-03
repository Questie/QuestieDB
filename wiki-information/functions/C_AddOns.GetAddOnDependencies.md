## Title: C_AddOns.GetAddOnDependencies

**Content:**
Returns a list of TOC dependencies.
`dep1, ... = C_AddOns.GetAddOnDependencies(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to `C_AddOns.GetNumAddOns`. Blizzard addons can only be queried by name.

**Returns:**
- `dep1, ...`
  - *string?* - A list of addon names that are a dependency.