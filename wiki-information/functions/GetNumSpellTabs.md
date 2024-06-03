## Title: GetNumSpellTabs

**Content:**
Returns the number of tabs in the spellbook.
`numTabs = GetNumSpellTabs()`

**Returns:**
- `numTabs`
  - *number* - number of ability tabs in the player's spellbook (e.g. 4 -- "General", "Arcane", "Fire", "Frost")

**Description:**
Each of the player's professions also gets a spellbook tab, but these tabs are not included in the count returned by this function.