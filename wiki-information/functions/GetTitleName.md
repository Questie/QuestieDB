## Title: GetTitleName

**Content:**
Returns the name of a player title.
`name, playerTitle = GetTitleName(titleId)`

**Parameters:**
- `titleId`
  - *number* - Ranging from 1 to GetNumTitles. Not necessarily an index as there can be missing/skipped IDs in between.

**Returns:**
- `name`
  - *string* - Name of the title.
- `playerTitle`
  - *boolean* - Seems to be true for all existing titles.

**Description:**
If the name has a trailing space, then the title is prefixed, otherwise it's suffixed.
```lua
/dump GetTitleName(2) -- "Corporal " → "Corporal Bob" (prefix)
/dump GetTitleName(36) -- "Champion of the Naaru" → "Alice, Champion of the Naaru" (suffix)
```

**Reference:**
- `GetCurrentTitle`
- `IsTitleKnown`