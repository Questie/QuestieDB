## Title: C_PetJournal.SetPetSortParameter

**Content:**
Changes the battle pet ordering in the pet journal.
`C_PetJournal.SetPetSortParameter(sortParameter)`

**Parameters:**
- `sortParameter`
  - *number* - Index of the ordering type that should be applied to `C_PetJournal.GetPetInfoByIndex` returns; one of the following global numeric values:
    - `LE_SORT_BY_NAME`
    - `LE_SORT_BY_LEVEL`
    - `LE_SORT_BY_RARITY`
    - `LE_SORT_BY_PETTYPE`

**Reference:**
- `C_PetJournal.GetPetSortParameter`

### Example Usage:
This function can be used to change the sorting order of pets in the Pet Journal. For instance, if you want to sort your pets by their level, you would call:
```lua
C_PetJournal.SetPetSortParameter(LE_SORT_BY_LEVEL)
```

### Addon Usage:
Large addons like "Rematch" use this function to allow users to customize the sorting of their pet lists based on different criteria such as name, level, rarity, or pet type. This enhances the user experience by providing flexible ways to organize and manage their pet collections.