## Title: GetSpellBaseCooldown

**Content:**
Gives the (unmodified) cooldown and global cooldown of an ability in milliseconds.
`cooldownMS, gcdMS = GetSpellBaseCooldown(spellid)`

**Parameters:**
- `spellid`
  - *number* - The spellid of your ability.

**Returns:**
- `cooldownMS`
  - *number* - Millisecond duration of the spell's cooldown (if any other than the global cooldown)
- `gcdMS`
  - *number* - Millisecond duration of the spell's global cooldown (if any)

**Notes and Caveats:**
Polling the second return value will discover if a particular spell is subject to GCD.

**Reference:**
`GetSpellCooldown`