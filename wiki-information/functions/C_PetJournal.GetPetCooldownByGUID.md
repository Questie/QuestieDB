## Title: C_PetJournal.GetPetCooldownByGUID

**Content:**
Returns the cooldown associated with summoning a battle pet companion.
`start, duration, isEnabled = C_PetJournal.GetPetCooldownByGUID(GUID)`

**Parameters:**
- `GUID`
  - *string* - GUID of a battle pet in your collection to query the cooldown of.

**Returns:**
- `start`
  - *number* - the time the cooldown period began, based on GetTime().
- `duration`
  - *number* - the duration of the cooldown period.
- `isEnabled`
  - *number* - 1 if the cooldown is not paused.

**Description:**
If the queried pet is not currently on a cooldown, this function will return 0, 0, 1.