## Title: IsCurrentSpell

**Content:**
Returns true if the specified spell ID is currently being casted or queued.
If the spell is current, then the action bar indicates its slot with a highlighted frame.
`isCurrent = IsCurrentSpell(spellID)`

**Parameters:**
- `spellID`
  - *number* - spell ID to query.

**Returns:**
- `isCurrent`
  - *boolean* - true if currently being casted or queued, false otherwise.