## Title: KBSetup_GetLanguageCount

**Content:**
Returns the number of languages in the knowledge base.
`count = KBSetup_GetLanguageCount()`

**Parameters:**
- `()` 

**Returns:**
- `count`
  - *integer* - The number of the available languages.

**Description:**
Seems to only work if `KBSetup_IsLoaded()` returns true.
On an EU client, this function returns 4 (enUS, deDE, frFR, esES).