## Title: DeclineName

**Content:**
Returns suggested declensions for a Russian name.
`genitive, dative, accusative, instrumental, prepositional = DeclineName(name, gender, declensionSet)`

**Parameters:**
- `name`
  - *string* - Nominative form of the player's or pet's name (string)
- `gender`
  - *number* - Gender for the returned names (for declensions of the player's name, should match the player's gender; for the pet's name, should be neuter).
    - `ID`
    - `Gender`
    - `1`
      - Neutrum / Unknown
    - `2`
      - Male
    - `3`
      - Female
- `declensionSet`
  - *number* - Ranging from 1 to `GetNumDeclensionSets()`. Lower indices correspond to "better" suggestions for the given name.

**Returns:**
- `genitive`
  - *string*
- `dative`
  - *string*
- `accusative`
  - *string*
- `instrumental`
  - *string*
- `prepositional`
  - *string*

**Description:**
Requires the ruRU client.
Static names for e.g NPCs are in `DeclinedWord.db2`, `DeclinedWordCases.db2`.