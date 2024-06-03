## Title: C_PetJournal.FindPetIDByName

**Content:**
Returns pet species and GUID by pet name.
`speciesId, petGUID = C_PetJournal.FindPetIDByName(petName)`

**Parameters:**
- `petName`
  - *string* - Name of the pet to find species/GUID of.

**Returns:**
- `speciesId`
  - *number* - Species ID of the first battle pet (or species) with the specified name, nil if no such pet exists.
- `petGUID`
  - *string* - GUID of the first battle pet collected by the player with the specified name, nil if the player has not collected any pets with the specified name.