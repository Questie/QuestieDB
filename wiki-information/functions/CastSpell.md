## Title: CastSpell

**Content:**
Casts a spell from the spellbook.
`CastSpell(spellIndex, spellbookType)`

**Parameters:**
- `spellIndex`
  - *number* - index of the spell to cast.
- `spellbookType`
  - *string* - spellbook to cast the spell from; one of
    - `BOOKTYPE_SPELL` ("spell") for player spells
    - `BOOKTYPE_PET` ("pet") for pet abilities

**Description:**
This function cannot be used from insecure execution paths except to "cast" trade skills (e.g. Cooking, Alchemy).

**Reference:**
- `CastSpellByName`

**Example Usage:**
```lua
-- Cast the first spell in the player's spellbook
CastSpell(1, BOOKTYPE_SPELL)

-- Cast the first ability in the pet's spellbook
CastSpell(1, BOOKTYPE_PET)
```

**Addons Usage:**
Many addons that automate spell casting or provide custom spell casting interfaces use `CastSpell`. For example, the popular addon "Bartender" uses it to allow players to cast spells directly from custom action bars.