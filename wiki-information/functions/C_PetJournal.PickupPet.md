## Title: C_PetJournal.PickupPet

**Content:**
Places a battle pet onto the mouse cursor.
`C_PetJournal.PickupPet(petID)`

**Parameters:**
- `petID`
  - *string* - GUID of a battle pet in your collection.

**Description:**
The function places a specific battle pet in your collection on your cursor.
Battle pets on your cursor can be placed on your action bars.
Attempting to pick up a battle pet that's already on the cursor clears the cursor instead.

**Reference:**
`GetCursorInfo`