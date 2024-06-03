## Title: SetMacroSpell

**Content:**
Changes the spell used for dynamic feedback for a macro.
`SetMacroSpell(index, spell)` or `SetMacroSpell(name, spell)`

**Parameters:**
- `index`
  - *number* - Index of the macro, using the values 1-36 for the first page and 37-54 for the second.
- `name`
  - *string* - Name of a macro.
- `spell`
  - *string* - Localized name of a spell to assign.
- `target`
  - *string* : UnitId - The unit to assign (for range indication).

**Description:**
When assigned to an action button, macros can provide dynamic feedback such as range indication, cooldown, and charges/quantity remaining.
Normally, this dynamic feedback corresponds to the action that the macro will take; however, this function directs the macro to provide feedback based on a particular spell instead.
This only changes the visual cues appearing on the action buttons, but not the actual logic. Clicking an action button executes the macro as written.

**Reference:**
`SetMacroItem`