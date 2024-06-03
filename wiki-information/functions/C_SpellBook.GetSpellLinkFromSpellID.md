## Title: C_SpellBook.GetSpellLinkFromSpellID

**Content:**
Needs summary.
`spellLink = C_SpellBook.GetSpellLinkFromSpellID(spellID)`

**Parameters:**
- `spellID`
  - *number*
- `glyphID`
  - *number?*

**Returns:**
- `spellLink`
  - *string*

**Example Usage:**
This function can be used to retrieve the link of a spell given its spell ID. This is particularly useful for addons that need to display or manipulate spell links.

**Addon Usage:**
Large addons like WeakAuras might use this function to fetch and display spell links in custom auras or notifications.