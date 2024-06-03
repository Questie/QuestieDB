## Title: GetAddOnMetadata

**Content:**
Returns the TOC metadata of an addon.
`value = GetAddOnMetadata(index, field)`
`GetAddOnMetadata(name, field)`

**Parameters:**
- `index`
  - *index* - The index in the addon list. Note that you cannot query Blizzard addons by index.
- `name`
  - *string* - The name of the addon, case insensitive.
- `field`
  - *string* - Field name, case insensitive. May be Title, Notes, Author, Version, or anything starting with X-

**Returns:**
- `value`
  - *string?* - The value of the field.