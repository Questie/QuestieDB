## Title: PickupCompanion

**Content:**
Places a mount onto the cursor.
`PickupCompanion(type, index)`

**Parameters:**
- `type`
  - *string* - companion type, either "MOUNT" or "CRITTER".
- `index`
  - *number* - index of the companion of the specified type to place on the cursor, ascending from 1.

**Description:**
You should only use this function to pick up mounts; for critters, this function has been superseded by `C_PetJournal.PickupPet`, and instead places an unusable spell on the cursor.

**Reference:**
- `GetCursorInfo`
- `GetCompanionInfo`
- `C_PetJournal.PickupPet`