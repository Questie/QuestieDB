## Event: SPELL_CONFIRMATION_PROMPT

**Title:** SPELL CONFIRMATION PROMPT

**Content:**
Fires when a spell confirmation prompt might be presented to the player.
`SPELL_CONFIRMATION_PROMPT: spellID, effectValue, message, duration, currencyTypesID, currencyCost, currentDifficulty`

**Payload:**
- `spellID`
  - *number* - Spell ID for the Confirmation Prompt Spell. These are very specific spells that only appear during this event.
- `effectValue`
  - *number* - The possible values for this are not entirely known, however, 1 does seem to be the confirmType when the prompt triggers a bonus roll.
- `message`
  - *string*
- `duration`
  - *number* - This number is in seconds. Typically, it is 180 seconds.
- `currencyTypesID`
  - *number* - The ID of the currency required if the prompt requires a currency (it does for bonus rolls).
- `currencyCost`
  - *number*
- `currentDifficulty`
  - *number*

**Content Details:**
After this event has fired, the client can respond with the functions AcceptSpellConfirmationPrompt and DeclineSpellConfirmationPrompt. Notably, the event does not guarantee that the player can actually cast the spell.