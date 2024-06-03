## Title: C_PetJournal.IsPetTypeChecked

**Content:**
Returns true if the pet type is checked.
`isChecked = C_PetJournal.IsPetTypeChecked(index)`

**Parameters:**
- `index`
  - *number* - Index (from 1 to GetNumPetTypes()) of all available pet types

**Returns:**
- `isChecked`
  - *boolean* - True if the filter is checked, false if the filter is unchecked

**Reference:**
- `C_PetJournal.SetAllPetTypesChecked`
- `C_PetJournal.SetPetTypeFilter`
- `C_PetJournal.GetNumPetTypes`