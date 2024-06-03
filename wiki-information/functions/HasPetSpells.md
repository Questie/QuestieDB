## Title: HasPetSpells

**Content:**
Returns the number of available abilities for the player's combat pet.
`hasPetSpells, petToken = HasPetSpells()`

**Returns:**
- `numSpells`
  - *number* - The number of pet abilities available, or nil if you do not have a pet with a spell book.
- `petToken`
  - *string* - Pet type, can be "DEMON" or "PET".

**Description:**
This `numSpells` return value is not the number that are on the pet bar, but the number of entries in the pet's spell book.