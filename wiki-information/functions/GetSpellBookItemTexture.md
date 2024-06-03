## Title: GetSpellBookItemTexture

**Content:**
Returns the icon texture of a spellbook item.
```lua
icon = GetSpellBookItemTexture(spell)
icon = GetSpellBookItemTexture(index, bookType)
```

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - `BOOKTYPE_SPELL` or `BOOKTYPE_PET` depending on if you wish to query the player or pet spellbook.
      - Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant Values:**
        - `BOOKTYPE_SPELL`
          - *"spell"* - The General, Class, Specs, and Professions tabs
        - `BOOKTYPE_PET`
          - *"pet"* - The Pet tab

**Returns:**
- `icon`
  - *number : FileID* - Icon fileId for the queried entry, or nil if the queried item does not exist.

**Reference:**
- `GetSpellBookItemInfo`
- `GetSpellBookItemName`