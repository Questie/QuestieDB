## Title: GetLanguageByIndex

**Content:**
Returns the languages that the character can speak by index.
`language, languageID = GetLanguageByIndex(index)`

**Parameters:**
- `index`
  - *number* - Ranging from 1 up to `GetNumLanguages()`

**Values:**
- `ID`
- `Name`
- `Patch`
  - 1: Orcish
  - 2: Darnassian
  - 3: Taurahe
  - 6: Dwarvish
  - 7: Common
  - 8: Demonic
  - 9: Titan
  - 10: Thalassian
  - 11: Draconic
  - 12: Kalimag
  - 13: Gnomish
  - 14: Zandali
  - 33: Forsaken (1.0.0)
  - 35: Draenei (2.0.0)
  - 36: Zombie (2.4.3)
  - 37: Gnomish Binary (2.4.3)
  - 38: Goblin Binary (2.4.3)
  - 39: Gilnean (4.0.1)
  - 40: Goblin (4.0.1)
  - 42: Pandaren (5.0.3)
  - 43: Pandaren (5.0.3)
  - 44: Pandaren (5.0.3)
  - 168: Sprite (5.0.3)
  - 178: Shath'Yar (6.x / 7.x)
  - 179: Nerglish (6.x / 7.x)
  - 180: Moonkin (6.x / 7.x)
  - 181: Shalassian (7.3.5)
  - 182: Thalassian (7.3.5)
  - 285: Vulpera (8.3.0)
  - 287: Complex Cipher (9.2.0)
  - 288: Basic Cypher (9.2.0)
  - 290: Metrial (9.2.0)
  - 291: Altonian (9.2.0)
  - 292: Sopranian (9.2.0)
  - 293: Aealic (9.2.0)
  - 294: Dealic (9.2.0)
  - 295: Trebelim (9.2.0)
  - 296: Bassalim (9.2.0)
  - 297: Embedded Languages (9.2.0)
  - 298: Unknowable (9.2.0)
  - 303: Furbolg (10.0.7)

**Returns:**
- `language`
  - *string*
- `languageID`
  - *number* - LanguageID

**Usage:**
Prints the available languages for the player.
```lua
for i = 1, GetNumLanguages() do
    print(GetLanguageByIndex(i))
end
```
-- e.g. for Blood elf
```lua
> "Orcish", 1
> "Thalassian", 10
```