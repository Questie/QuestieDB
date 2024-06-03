## Title: DeclineSpellConfirmationPrompt

**Content:**
Declines a spell confirmation prompt (e.g. bonus loot roll).
`DeclineSpellConfirmationPrompt(spellID)`

**Parameters:**
- `spellID`
  - *number* - spell ID of the prompt to decline.

**Description:**
SPELL_CONFIRMATION_PROMPT fires when a spell confirmation prompt might be presented to the player; it provides the spellID and information about the type, text, and duration of the confirmation prompt.
Calling this function declines the spell prompt: the player does not perform the prompted action.

**Reference:**
- `AcceptSpellConfirmationPrompt`

### Example Usage:
This function can be used in scenarios where an addon or script needs to automatically decline certain spell confirmation prompts, such as declining bonus loot rolls in a raid environment.

### Addon Usage:
Large addons like Deadly Boss Mods (DBM) might use this function to automatically decline certain prompts during encounters to ensure that the player's focus remains on the fight mechanics rather than on additional prompts.