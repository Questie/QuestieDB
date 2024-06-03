## Title: GetFonts

**Content:**
Returns a list of available fonts.
`fonts = GetFonts()`

**Returns:**
- `fonts`
  - *string* - a table containing font object names.

**Description:**
The names in the returned table may correspond to globally accessible font objects of the same name.
The names in the returned table can be used in conjunction with `GetFontInfo` to query font attributes such as sizing or coloring information.

**Reference:**
- `GetFontInfo`