## Title: GetNumDeclensionSets

**Content:**
Returns the number of suggested declension sets for a Russian name.
`numDeclensionSets = GetNumDeclensionSets(name, gender)`

**Parameters:**
- `name`
  - *string*
- `gender`
  - *number*

**Returns:**
- `numDeclensionSets`
  - *number* - Used for `DeclineName()`

**Description:**
Requires the ruRU client.
Declension sets are sets of additional names prompted during character creation in the ruRU client.
Static names for e.g NPCs are in `DeclinedWord.db2`, `DeclinedWordCases.db2`.