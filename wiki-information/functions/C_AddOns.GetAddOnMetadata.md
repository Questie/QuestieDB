## Title: C_AddOns.GetAddOnMetadata

**Content:**
Returns the TOC metadata of an addon.
`value = C_AddOns.GetAddOnMetadata(name, variable)`

**Parameters:**
- `name`
  - *string|number* - The name or index of the addon, case insensitive.
- `variable`
  - *string* - Variable name, case insensitive. May be Title, Notes, Author, Version, or anything starting with X-.

**Returns:**
- `value`
  - *string?* - The value of the variable.

**Description:**
Unlike `GetAddOnMetadata`, this function will raise an "Invalid AddOn name" error if supplied the name of an addon that does not exist.