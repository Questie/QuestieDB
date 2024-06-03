## Title: C_PetJournal.PetIsRevoked

**Content:**
Returns whether or not the pet is revoked.
`isRevoked = C_PetJournal.PetIsRevoked(petID)`

**Parameters:**
- `petID`
  - *string* - Unique identifier for this specific pet.

**Returns:**
- `isRevoked`
  - *boolean* - true if the pet is revoked.

**Description:**
Revoked pets are pets that have been stripped from the player in every fashion except for their name. They remain in the Pet Journal, but they cannot be summoned or used in battle. In addition, the rarity border and level icon will not appear around and over the pet's name in the Pet Journal's scrolling list.
This function returns true for Blizzard Pet Store pets on the PTR, which suggests that `isRevoked` is only ever true for pets that cost money and have not been authorized for a specific World of Warcraft account. This mechanic is likely in place to prevent characters from transferring with an unused Blizzard Pet Store pet to a different account that does not have access to that pet.