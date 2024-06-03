## Title: C_PetJournal.GetOwnedBattlePetString

**Content:**
Returns a formatted string indicating how many of a battle pet species the player has collected.
`ownedString = C_PetJournal.GetOwnedBattlePetString(speciesId)`

**Parameters:**
- `speciesId`
  - *number* - Battle pet species ID.

**Returns:**
- `ownedString`
  - *string* - a description of how many pets of this species you've collected, e.g. `"|cFFFFD200Collected (1/3)"`, or `nil` if you haven't collected any.