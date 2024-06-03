## Title: C_UnitAuras.AuraIsPrivate

**Content:**
Needs summary.
`isPrivate = C_UnitAuras.AuraIsPrivate(spellID)`

**Parameters:**
- `spellID`
  - *number*

**Returns:**
- `isPrivate`
  - *boolean*

**Example Usage:**
This function can be used to determine if a specific aura (identified by its spell ID) is private. This can be useful in addons that manage or display aura information, ensuring that private auras are handled appropriately.

**Addon Usage:**
Large addons like WeakAuras might use this function to filter out private auras when displaying aura information to the player, ensuring that only relevant and non-private auras are shown in custom UI elements.