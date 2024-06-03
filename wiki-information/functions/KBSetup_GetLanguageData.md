## Title: KBSetup_GetLanguageData

**Content:**
Returns information about a language.
`id, caption = KBSetup_GetLanguageData(index)`

**Parameters:**
- `index`
  - *number* - Range from 1 to `KBSetup_GetLanguageCount()`

**Returns:**
- `id`
  - *number* - The internal language ID.
- `caption`
  - *string* - The (localized?) name of the language.

**Description:**
Seems to only work if `KBSetup_IsLoaded()` returns true.