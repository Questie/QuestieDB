## Title: GetMacroIndexByName

**Content:**
Returns the index for a macro by name.
`macroSlot = GetMacroIndexByName(name)`

**Parameters:**
- `name`
  - *string* - Macro name to query.

**Returns:**
- `macroSlot`
  - *number* - Macro slot index containing a macro with the queried name, or 0 if no such slot exists.

**Description:**
Slots 1-120 are used for general macros, and 121-138 for character-specific macros.

**Reference:**
[GetMacroInfo](https://wowpedia.fandom.com/wiki/API_GetMacroInfo)