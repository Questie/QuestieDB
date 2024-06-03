## Title: GetSpellLink

**Content:**
Returns the hyperlink for a spell.
`link, spellId = GetSpellLink(spell)`
`link, spellId = GetSpellLink(index, bookType)`

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
- `link`
  - *string* : spellLink
- `spellID`
  - *number*

**Usage:**
- Prints a clickable spell link, for Flash Heal.
  ```lua
  /run print(GetSpellLink(2061))
  ```
- Dumps an (escaped) spell link.
  ```lua
  /dump GetSpellLink(2061)
  -- "|cff71d5ff|Hspell:2061:0|h|h|r", 2061
  ```
- Dumps the first spell from your spell book.
  ```lua
  /dump GetSpellLink(1, BOOKTYPE_SPELL)
  -- "|cff71d5ff|Hspell:6603:0|h|h|r", 6603
  ```