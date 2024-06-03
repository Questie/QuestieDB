## Title: GetGlyphLink

**Content:**
Returns a link to a glyph specified by index and talent group.
`link = GetGlyphLink(index)`

**Parameters:**
- `index`
  - *number* - Ranging from 1 to 6, the glyph's index. See Notes for more information.
- `talentGroup`
  - *number?* - Optional, ranging from 1 (primary) to 2 (secondary) the talent group to query. Defaults to the currently active talent group.

**Returns:**
- `link`
  - *string* - The link to the glyph if it's populated, otherwise empty string.

**Notes and Caveats:**
The indices are not in a logical order, see table and gallery picture below for reference.

**Glyph indices:**
| Index | Glyph type | Level to unlock |
|-------|-------------|-----------------|
| 1     | Major       | 15              |
| 2     | Minor       | 15              |
| 3     | Minor       | 50              |
| 4     | Major       | 30              |
| 5     | Minor       | 70              |
| 6     | Major       | 80              |

**Miscellaneous:**
Indices for each glyph slot