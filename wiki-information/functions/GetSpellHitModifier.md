## Title: GetSpellHitModifier

**Content:**
Returns the amount of Spell Hit %, not from Spell Hit Rating, that your character has.
`hitMod = GetSpellHitModifier()`

**Returns:**
- `hitMod`
  - *number* - hit modifier (e.g. 16 for 16%)

**Usage:**
Returns the Spell Hit Chance displayed in the paperdoll.
`/dump GetCombatRatingBonus(CR_HIT_SPELL) + GetSpellHitModifier();`

**Reference:**
GetHitModifier()