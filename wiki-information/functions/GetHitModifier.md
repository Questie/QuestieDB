## Title: GetHitModifier

**Content:**
Returns the amount of Melee Hit %, not from Melee Hit Rating, that your character has.
`hitMod = GetHitModifier()`

**Returns:**
- `hitMod`
  - *number* - hit modifier (e.g. 16 for 16%)

**Usage:**
Returns the Melee Hit Chance displayed in the paper doll.
```lua
/dump GetCombatRatingBonus(CR_HIT_MELEE) + GetHitModifier()
```

**Reference:**
API GetSpellHitModifier