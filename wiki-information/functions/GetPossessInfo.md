## Title: GetPossessInfo

**Content:**
Returns info for an action on the possession bar.
`texture, spellID, enabled = GetPossessInfo(index)`

**Parameters:**
- `index`
  - *number* - The slot of the possess bar to check, ascending from 1.

**Returns:**
- `texture`
  - *string* - The icon texture used for this slot, nil if the slot is empty
- `spellID`
  - *number* - The name of the action in this slot, nil if the slot is empty.
- `enabled`
  - *boolean* - true if there is an action in this slot, nil otherwise.

**Description:**
The possession bar is shown by the default UI (like a stance bar) while the player is controlling another target, such as while channeling.
Typically, the first slot contains the spell used to control the other unit (which does nothing), while the second slot has a "Cancel" action that ends the effect.

**Reference:**
- `IsPossessBarVisible`