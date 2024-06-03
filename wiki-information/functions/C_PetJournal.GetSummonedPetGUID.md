## Title: C_PetJournal.GetSummonedPetGUID

**Content:**
Returns information about a battle pet.
`summonedPetGUID = C_PetJournal.GetSummonedPetGUID()`

**Returns:**
- `summonedPetGUID`
  - *string* - GUID identifying the currently-summoned battle pet, or nil if no battle pet is summoned.

**Description:**
Blizzard has moved all petIDs over to the "petGUID" system, but left all of their functions using the petID terminology (not the petGUID terminology) except for this one. For consistency, the term "petID" should continue to be used.

**Reference:**
- `C_PetJournal.SummonPetByGUID`