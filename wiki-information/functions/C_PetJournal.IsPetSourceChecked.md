## Title: C_PetJournal.IsPetSourceChecked

**Content:**
Returns true if the pet source is checked.
`isChecked = C_PetJournal.IsPetSourceChecked(index)`

**Parameters:**
- `index`
  - *number* - Index (from 1 to GetNumPetSources()) of all available pet sources

**Returns:**
- `isChecked`
  - *boolean* - True if the source is checked, false if the source is unchecked

**Reference:**
- `C_PetJournal.SetAllPetSourcesChecked`
- `C_PetJournal.SetPetSourceChecked`
- `C_PetJournal.GetNumPetSources`