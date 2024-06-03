## Title: C_PetJournal.SummonPetByGUID

**Content:**
Summons (or dismisses) a pet.
`C_PetJournal.SummonPetByGUID(petID)`

**Parameters:**
- `petID`
  - *string* - GUID of the battle pet to summon. If the pet is already summoned, it will be dismissed.

**Description:**
You can dismiss the currently-summoned battle pet by running:
```lua
C_PetJournal.SummonPetByGUID(C_PetJournal.GetSummonedPetGUID())
```
Note that this will throw an error if you do not have a pet summoned.
Blizzard has moved all petIDs over to the "petGUID" system, but left all of their functions using the petID terminology (not the petGUID terminology) except for this one. For consistency, the term "petID" should continue to be used.

**Reference:**
- `C_PetJournal.GetSummonedPetGUID`

### Example Usage:
This function can be used in macros or addons to manage battle pets. For example, you could create a macro to summon a specific pet by its GUID:
```lua
/run C_PetJournal.SummonPetByGUID("BattlePet-0-000012345678")
```

### Addon Usage:
Large addons like Rematch use this function to manage pet teams and automate the summoning and dismissing of pets based on the player's preferences and the current situation in the game.