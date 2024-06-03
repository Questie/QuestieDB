## Title: SpellStopTargeting

**Content:**
Cancels the spell awaiting target selection.
`SpellStopTargeting()`

**Description:**
Also cancels some types of weapon buffs when they ask for confirmation. For example, if you attempt to apply a poison to a weapon that already has a poison, the game will ask you to confirm the replacement. You can accept the replacement with `ReplaceEnchant()` or cancel the replacement with `SpellStopTargeting()`.