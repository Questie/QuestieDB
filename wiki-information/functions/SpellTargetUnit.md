## Title: SpellTargetUnit

**Content:**
Casts the spell awaiting target selection on the unit.
`SpellTargetUnit(unitId)`

**Parameters:**
- `unitId`
  - *string* : UnitId - The unit you wish to cast the spell on.

**Example Usage:**
```lua
-- Assuming you have a spell ready to be cast and you want to target the player
SpellTargetUnit("player")
```

**Description:**
The `SpellTargetUnit` function is used to cast a spell that is currently awaiting target selection on a specified unit. This is particularly useful in macros or scripts where you need to automate spell casting on specific units.

**Usage in Addons:**
Many large addons, such as HealBot and Clique, use `SpellTargetUnit` to facilitate quick and efficient healing or buffing by allowing players to cast spells on units directly through their custom interfaces. This function helps streamline the process of targeting and casting spells, making gameplay smoother and more efficient.