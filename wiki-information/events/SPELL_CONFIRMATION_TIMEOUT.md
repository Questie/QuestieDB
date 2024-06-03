## Event: SPELL_CONFIRMATION_TIMEOUT

**Title:** SPELL CONFIRMATION TIMEOUT

**Content:**
Fires when a spell confirmation prompt was not accepted via AcceptSpellConfirmationPrompt or declined via DeclineSpellConfirmationPrompt within the allotted time (usually 3 minutes).
`SPELL_CONFIRMATION_TIMEOUT: spellID, effectValue`

**Payload:**
- `spellID`
  - *number*
- `effectValue`
  - *number*