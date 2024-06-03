## Title: GetMacroInfo

**Content:**
Returns info for a macro.
`name, icon, body = GetMacroInfo(macro)`

**Parameters:**
- `macro`
  - *number|string* - Macro slot index or the name of the macro. Slots 1 through 120 are general macros; 121 through 138 are per-character macros.

**Returns:**
- `name`
  - *string* - The name of the macro.
- `icon`
  - *number : fileID* - Macro icon texture.
- `body`
  - *string* - Macro contents.