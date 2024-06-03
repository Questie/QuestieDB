## Title: GetAddOnDependencies

**Content:**
Returns the TOC dependencies of an addon.
`dep1, dep2, ... = GetAddOnDependencies(name)`

**Parameters:**
- `name`
  - *string|number* - The name of the addon to be queried, or an index from 1 to GetNumAddOns. The state of Blizzard addons can only be queried by name.

**Returns:**
- `dep1, dep2, ...`
  - *string* - List of addon names that are a required dependency.