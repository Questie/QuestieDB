## Event: SPELL_DATA_LOAD_RESULT

**Title:** SPELL DATA LOAD RESULT

**Content:**
Fires when data is available in response to C_Spell.RequestLoadSpellData.
`SPELL_DATA_LOAD_RESULT: spellID, success`

**Payload:**
- `spellID`
  - *number*
- `success`
  - *boolean* - True if the spell was successfully queried from the server. Might return false when only partial spell data is available, e.g. everything except the spell description.

**Related Information:**
SpellMixin