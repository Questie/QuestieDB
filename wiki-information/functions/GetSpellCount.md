## Title: GetSpellCount

**Content:**
Returns the number of times a spell can be cast. Generally used for spells limited by the number of available item reagents.
`numCasts = GetSpellCount(spell)`
`numCasts = GetSpellCount(index, bookType)`

**Parameters:**
- `spell`
  - *number|string* - Spell ID or Name. When passing a name requires the spell to be in your Spellbook.
- **Spellbook args**
  - `index`
    - *number* - Spellbook slot index, ranging from 1 through the total number of spells across all tabs and pages.
  - `bookType`
    - *string* - BOOKTYPE_SPELL or BOOKTYPE_PET depending on if you wish to query the player or pet spellbook.
      - Internally the game only tests if this is equal to "pet" and treats any other string value as "spell".
      - **Constant**
        - **Value**
        - **Description**
        - `BOOKTYPE_SPELL`
          - "spell" - The General, Class, Specs and Professions tabs
        - `BOOKTYPE_PET`
          - "pet" - The Pet tab

**Returns:**
- `numCasts`
  - *number*