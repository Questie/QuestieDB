## Title: GetSpellLossOfControlCooldown

**Content:**
Returns information about a loss-of-control cooldown affecting a spell.
`start, duration = GetSpellLossOfControlCooldown(spellSlot or spellName or spellID)`

**Parameters:**
- `spellSlot`
  - *number* - spell book slot index, ascending from 1.
- `bookType`
  - *string* - spell book type token, e.g. "spell" from player's spell book.
- or
- `spellName`
  - *string* - name of a spell in the player's spell book.
- or
- `spellID`
  - *number* - spell ID of a spell accessible to the player.

**Returns:**
- `start`
  - *number* - time at which the loss-of-control cooldown began, per GetTime.
- `duration`
  - *number* - duration of the loss-of-control cooldown in seconds; 0 if the spell is not currently affected by a loss-of-control cooldown.

**Description:**
If the spell is not affected by a loss-of-control cooldown, this function returns 0, 0.

**Reference:**
GetActionLossOfControlCooldown