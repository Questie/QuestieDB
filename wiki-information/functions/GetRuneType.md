## Title: GetRuneType

**Content:**
Gets the type of rune for a given rune ID.
`runeType = GetRuneType(id)`

**Parameters:**
- `id`
  - The rune's id. A number between 1 and 6 denoting which rune to be queried.

**Returns:**
- `runeType` - The type of rune that it is.
  - `1` : RUNETYPE_BLOOD
  - `2` : RUNETYPE_CHROMATIC
  - `3` : RUNETYPE_FROST
  - `4` : RUNETYPE_DEATH

**Note:**
"CHROMATIC" refers to Unholy runes.