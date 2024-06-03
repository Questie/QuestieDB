## Title: C_PetJournal.GetNumCollectedInfo

**Content:**
Returns the number of collected battle pets of a particular species.
`numCollected, limit = C_PetJournal.GetNumCollectedInfo(speciesId)`

**Parameters:**
- `speciesId`
  - *number* - Battle pet species ID to query, e.g. 635 for Adder battle pets.

**Returns:**
- `numCollected`
  - *number* - Number of battle pets of the queried species the player has collected.
- `limit`
  - *number* - Maximum number of battle pets of the queried species the player may collect.