## Title: GetStablePetInfo

**Content:**
Returns info for a specific stabled pet.
`petIcon, petName, petLevel, petType, petTalents = GetStablePetInfo(index)`

**Parameters:**
- `index`
  - *number* - The index of the pet slot, 1 through 5 are the hunter's active pets, 6 through 25 are the hunter's stabled pets.

**Returns:**
- `petIcon`
  - *string* - The path to texture to use as the icon for the pet, see `GetPetIcon()`.
- `petName`
  - *string* - The pet name, see `UnitName()`.
- `petLevel`
  - *number* - The pet level, see `UnitLevel()`.
- `petType`
  - *string* - The localized pet family, see `UnitCreatureFamily()`.
- `petTalents`
  - *string* - The pet's talent group.