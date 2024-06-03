## Title: IsUsableSpell

**Content:**
Determines whether a spell can be used by the player character.
`usable, noMana = IsUsableSpell(spell)`
`usable, noMana = IsUsableSpell(index, bookType)`

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - `BOOKTYPE_SPELL` or `BOOKTYPE_PET` depending on if you wish to query the player or pet spellbook.
      - Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant**
        - **Value**
        - **Description**
        - `BOOKTYPE_SPELL`
          - "spell" - The General, Class, Specs and Professions tabs
        - `BOOKTYPE_PET`
          - "pet" - The Pet tab

**Returns:**
- `usable`
  - *boolean* - True if the spell is usable, false otherwise. A spell might be un-usable for a variety of reasons, such as:
    - The player hasn't learned the spell
    - The player lacks required mana or reagents.
    - Reactive conditions haven't been met.
- `noMana`
  - *boolean* - True if the spell cannot be cast due to low mana, false otherwise.

**Usage:**
The following code snippet will check if the spell 'Healing Touch' can be cast:
```lua
usable, nomana = IsUsableSpell("Curse of Elements");
if (not usable) then
  if (not nomana) then
    message("The spell cannot be cast");
  else
    message("You do not have enough mana to cast the spell");
  end
else
  message("The spell may be cast");
end
```

The following code snippet will check if the 20th spell in the player's spellbook is usable:
```lua
usable, nomana = IsUsableSpell(20, BOOKTYPE_SPELL);
print(GetSpellName(20, BOOKTYPE_SPELL) .. " is " .. (usable and "" or "not ") .. " usable.");
```