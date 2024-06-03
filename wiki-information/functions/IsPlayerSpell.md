## Title: IsPlayerSpell

**Content:**
Returns whether the player has learned a particular spell.
`isKnown = IsPlayerSpell(spellID)`

**Parameters:**
- `spellID`
  - *number* - Spell ID of the spell to query, e.g. 1953 for Blink.

**Returns:**
- `isKnown`
  - *boolean* - true if the player can cast this spell (or a different spell that overrides this spell), false otherwise.

**Description:**
Spells can be permanently or temporarily overridden by other spells as a result of procs, talents, or other spell mechanics, e.g.
- `Wrath` is overridden by `Starfire` while in Solar Eclipse.
- `Freezing Trap` replaces trap spells by ranged variants.
- `Metamorphosis` replaces a permanent base spell.
- `Demonbolt` replaces with different spells.

Querying the base (replaced) spell will also return true if any of its overrides are currently active.
Querying an overriding spell may or may not return true even if that spell is currently known, depending on the particular spell.

**Reference:**
- `GetSpellInfo`

**Example Usage:**
This function can be used to check if a player has learned a specific spell before attempting to cast it or display it in a UI element. For instance, an addon could use `IsPlayerSpell` to determine if a player has learned a particular talent or ability and then update the UI accordingly.

**Addon Usage:**
Large addons like WeakAuras use `IsPlayerSpell` to dynamically update auras and notifications based on the player's current abilities and talents. This ensures that the addon only shows relevant information and triggers for spells the player can actually use.