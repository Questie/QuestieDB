## Title: AcceptSpellConfirmationPrompt

**Content:**
Confirms a spell confirmation prompt (e.g. bonus loot roll).
`AcceptSpellConfirmationPrompt(spellID)`

**Parameters:**
- `spellID`
  - *number* - spell ID of the prompt to confirm.

**Description:**
SPELL_CONFIRMATION_PROMPT fires when a spell confirmation prompt might be presented to the player; it provides the spellID and information about the type, text, and duration of the confirmation. Notably, the event does not guarantee that the player can actually cast the spell.
Calling this function accepts the spell prompt, performing the action in question.
SPELL_CONFIRMATION_TIMEOUT fires if the spell is not confirmed within the prompt duration.

**Reference:**
- [DeclineSpellConfirmationPrompt](#)