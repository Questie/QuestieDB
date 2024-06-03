## Title: IsSpellInRange

**Content:**
Returns 1 if the player is in range to use the specified spell on the target unit, 0 otherwise.
`inRange = IsSpellInRange(spellName, unit)`
`inRange = IsSpellInRange(index, bookType, unit)`

**Parameters:**
- `spellName`
  - *string* - The localized spell name. The player must know the spell.
- `unit`
  - *string : UnitId* - The unit to use as a target for the spell.

**Spellbook args:**
- `index`
  - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
- `bookType`
  - *string* - BOOKTYPE_SPELL or BOOKTYPE_PET depending on if you wish to query the player or pet spellbook.
    - Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".

**Constant:**
- `BOOKTYPE_SPELL`
  - *"spell"* - The General, Class, Specs and Professions tabs
- `BOOKTYPE_PET`
  - *"pet"* - The Pet tab

**Returns:**
- `inRange`
  - *number?* - 1 if the target is in range of the spell, 0 if the target is not in range of the spell, nil if the provided arguments were invalid or inapplicable.

**Description:**
This takes into account talents, and can be used to determine the approximate distance to your raid members.
The function returns nil if:
- The spell cannot be cast on the unit. i.e. on a friendly unit, or on a hostile unit (such as a mind-controlled raid member)
- If the unit is not 'visible' (per UnitIsVisible) or does not exist (per UnitExists)
- The current player does not know this spell (so you cannot use 'Heal' to test 40 yard range for anyone other than a priest)
- The spell can only be cast on the player (i.e. a self-buff such as or )

**Usage:**
```lua
if IsSpellInRange("Flash Heal", "target") == 1 then
  print("target is in healing range")
else
  print("cannot heal target")
end
```