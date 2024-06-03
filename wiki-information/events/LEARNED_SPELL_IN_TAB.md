## Event: LEARNED_SPELL_IN_TAB

**Title:** LEARNED SPELL IN TAB

**Content:**
Fired when a new spell/ability is added to the spellbook. e.g. When training a new or a higher level spell/ability.
`LEARNED_SPELL_IN_TAB: spellID, skillInfoIndex, isGuildPerkSpell`

**Payload:**
- `spellID`
  - *number*
- `skillInfoIndex`
  - *number* - Number of the tab which the spell/ability is added to.
- `isGuildPerkSpell`
  - *boolean*