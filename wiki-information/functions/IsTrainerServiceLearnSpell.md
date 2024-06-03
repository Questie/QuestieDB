## Title: IsTrainerServiceLearnSpell

**Content:**
Returns the type of trainer spell in the trainer window.
`isLearnSpell, isPetLearnSpell = IsTrainerServiceLearnSpell(index)`

**Parameters:**
- `index`
  - *number* - The index of the spell in the trainer window.

**Returns:**
- `isLearnSpell`
  - *number* - Returns 1 if the spell is a class spell or a learnable profession spell, nil otherwise.
- `isPetLearnSpell`
  - *number* - Returns 1 if a pet spell, nil otherwise.

**Reference:**
- `GetTrainerServiceInfo()`