## Title: GetLocale

**Content:**
Returns the game client locale.
`locale = GetLocale()`

**Returns:**
- `locale`
  - *string*

**Usage:**
```lua
if GetLocale() == "frFR" then
    print("bonjour")
else
    print("hello")
end
```

**Parameters:**
- `localeId`
- `localeName`

**Description:**
1. `enUS` - English (United States) (enGB clients return enUS)
2. `koKR` - Korean (Korea)
3. `frFR` - French (France)
4. `deDE` - German (Germany)
5. `zhCN` - Chinese (Simplified, PRC)
6. `esES` - Spanish (Spain)
7. `zhTW` - Chinese (Traditional, Taiwan)
8. `esMX` - Spanish (Mexico)
9. `ruRU` - Russian (Russia)
10. `ptBR` - Portuguese (Brazil)
11. `itIT` - Italian (Italy)