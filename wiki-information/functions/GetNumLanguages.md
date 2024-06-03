## Title: GetNumLanguages

**Content:**
Returns the number of languages your character can speak.
`numLanguages = GetNumLanguages()`

**Returns:**
- `numLanguages`
  - *number*

**Usage:**
Prints the available languages for the player.
```lua
for i = 1, GetNumLanguages() do
    print(GetLanguageByIndex(i))
end
-- e.g. for Blood elf
-- > "Orcish", 1
-- > "Thalassian", 10
```