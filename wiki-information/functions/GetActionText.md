## Title: GetActionText

**Content:**
Returns the label text for an action.
`text = GetActionText(actionSlot)`

**Parameters:**
- `actionSlot`
  - *ActionSlot* - The queried slot.

**Returns:**
- `text`
  - *String* - The action's text, if present. Macro actions use their names for their action text.
  - *nil* - If the slot has no action text, or is empty. Most standard WoW action icons don't have action text.