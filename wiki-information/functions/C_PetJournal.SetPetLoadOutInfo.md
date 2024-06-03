## Title: C_PetJournal.SetPetLoadOutInfo

**Content:**
Places the specified pet into a battle pet slot.
`C_PetJournal.SetPetLoadOutInfo(slotIndex, petID)`

**Parameters:**
- `slotIndex`
  - *number* - Battle pet slot index, integer between 1 and 3.
- `petID`
  - *string* - Battle pet GUID of a pet in your collection to move into the battle pet slot.

**Description:**
If the pet specified by `petID` is already in a battle pet slot, the pets are exchanged.

**Reference:**
- `C_PetJournal.SetAbility`
- `C_PetJournal.GetPetLoadOutInfo`

### Example Usage:
This function can be used in an addon to automate the process of setting up battle pets for pet battles. For instance, an addon could allow users to save and load different pet battle teams quickly.

### Addon Usage:
- **Rematch**: A popular addon that helps players manage their pet battle teams. It uses `C_PetJournal.SetPetLoadOutInfo` to set pets into specific slots when loading saved teams.