## Title: UnitPlayerOrPetInParty

**Content:**
Returns true if a different unit or pet is a member of the party.
`inMyParty = UnitPlayerOrPetInParty(unit)`

**Parameters:**
- `unit`
  - *string* - The unit to check for party membership.

**Returns:**
- `inMyParty`
  - *boolean* - 1 if the unit is another player or another player's pet in your party, nil otherwise.

**Description:**
This function returns nil if the unit is the player, or the player's pet.