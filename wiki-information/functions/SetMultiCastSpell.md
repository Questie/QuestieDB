## Title: SetMultiCastSpell

**Content:**
Sets the totem spell for a specific totem bar slot.
`SetMultiCastSpell(actionID, spellID)`

**Parameters:**
- `actionID`
  - *number* - The totem bar slot number.
    - Call of the...
      - Totem slot
        - Fire
        - Earth
        - Water
        - Air
      - Elements
        - 133
        - 134
        - 135
        - 136
      - Ancestors
        - 137
        - 138
        - 139
        - 140
      - Spirits
        - 141
        - 142
        - 143
        - 144
- `spellId`
  - *number* - The global spell number, found on Wowhead or through COMBAT_LOG_EVENT.

**Usage:**
`SetMultiCastSpell(134, 2484)`

**Result:**
Sets on .