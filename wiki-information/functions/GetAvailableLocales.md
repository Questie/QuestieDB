## Title: GetAvailableLocales

**Content:**
Returns the available locale strings.
`locale1, locale2, ... = GetAvailableLocales()`

**Parameters:**
- `ignoreLocalRestrictions`
  - *boolean?* - If true, returns the complete list of locales.

**Returns:**
- `locale1, locale2, ...`
  - *string*

**Usage:**
```lua
/dump GetAvailableLocales() -- "enUS", "esMX", "ptBR" (on a US server)
/dump GetAvailableLocales(true) -- "enUS", "koKR", "frFR", "deDE", "zhCN", "esES", "zhTW", "esMX", "ruRU", "ptBR", "itIT"
```