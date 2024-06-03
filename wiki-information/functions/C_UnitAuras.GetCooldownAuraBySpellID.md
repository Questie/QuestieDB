## Title: C_UnitAuras.GetCooldownAuraBySpellID

**Content:**
Obtains the spell ID of a passive cooldown effect associated with a spell.
`passiveCooldownSpellID = C_UnitAuras.GetCooldownAuraBySpellID(spellID)`

**Parameters:**
- `spellID`
  - *number* - The spell ID to query.

**Returns:**
- `passiveCooldownSpellID`
  - *number?* - The spell ID of an associated passive aura effect, if any.

**Description:**
This API is used in conjunction with `C_UnitAuras.GetPlayerAuraBySpellID` to display passive effect cooldowns on action buttons.