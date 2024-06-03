## Title: GetSpellAutocast

**Content:**
Returns true if a (pet) spell is autocastable.
`autocastable, autostate = GetSpellAutocast("spellName" or spellId, bookType)`

**Parameters:**
- `spellName`
  - *string* - the name of the spell.
- `spellId`
  - *number* - the offset (position) of the spell in the spellbook. SpellId can change when you learn new spells.
- `bookType`
  - *string* - Either BOOKTYPE_SPELL ("spell") or BOOKTYPE_PET ("pet").

**Returns:**
- `autocastable`
  - *number* - whether a spell is autocastable.
    - Returns 1 if the spell is autocastable, nil otherwise.
- `autostate`
  - *number* - whether a spell is currently set to autocast.
    - Returns 1 if the spell is currently set for autocast, nil otherwise.

**Description:**
As of patch 3.0.3, the only auto-castable spells exist in the pet spellbook (BOOKTYPE_PET).
Both return values will be nil in the following conditions:
- The spell is not autocastable
- The spell does not exist (or you don't know it)

**Example Usage:**
This function can be used in macros or addons to check if a pet spell is set to autocast and to manage pet abilities more effectively. For instance, a hunter might use this to ensure their pet's Growl ability is set to autocast when tanking.

**Addons:**
Large addons like PetTracker might use this function to display or manage pet abilities, ensuring that the pet's autocast settings are correctly configured for optimal performance in various situations.