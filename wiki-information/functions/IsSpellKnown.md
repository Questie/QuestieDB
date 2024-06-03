## Title: IsSpellKnown

**Content:**
Returns whether the player (or pet) knows the given spell.
`isKnown = IsSpellKnown(spellID)`

**Parameters:**
- `spellID`
  - *number* - the spell ID number
- `isPetSpell`
  - *boolean?* - if true, will check if the currently active pet knows the spell; if false or omitted, will check if the player knows the spell

**Returns:**
- `isKnown`
  - *boolean* - whether the player (or pet) knows the given spell

**Description:**
This function may return false when querying learned spells that are passive effects. Consider using `IsPlayerSpell` for these.
Returns false if querying a spell that has "replaced" a known spell, which returns true whether or not it's replaced (i.e. Retribution's Templar's Verdict (85256) will always be true and Final Verdict (336872) will be false whether or not you have the related legendary equipped). In these cases, use `IsSpellKnownOrOverridesKnown(spellID)` to check for spells like Final Verdict.

**Reference:**
- `IsPlayerSpell`
- `IsSpellKnownOrOverridesKnown`