## Title: GetSpellBookItemInfo

**Content:**
Returns info for a spellbook item.
`spellType, id = GetSpellBookItemInfo(spellName)`
`spellType, id = GetSpellBookItemInfo(index, bookType)`

**Parameters:**
- `spellName`
  - *string* - Requires the spell to be in your Spellbook.
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
- `spellType`
  - *string* - The type of the spell:
- `id`
  - *number*
    - For `SPELL` and `FUTURESPELL`, the SpellID used in `GetSpellInfo()`
    - For `PETACTION`, the ActionID used in `C_ActionBar.HasPetActionButtons()`; furthermore, the SpellID can be obtained by applying the bitmask `0xFFFFFF`.
    - For `FLYOUT`, the FlyoutID used in `GetFlyoutInfo()`

**Description:**
Related API: `GetSpellBookItemName`

**Usage:**
Prints all spells in the spellbook for the player, except the profession tab ones.
```lua
local spellFunc = {
    SPELL = GetSpellInfo,
    FUTURESPELL = GetSpellInfo,
    FLYOUT = GetFlyoutInfo,
}
for i = 1, GetNumSpellTabs() do
    local _, _, offset, numSlots = GetSpellTabInfo(i)
    for j = offset+1, offset+numSlots do
        local spellType, id = GetSpellBookItemInfo(j, BOOKTYPE_SPELL)
        local spellName = spellFunc[id]
        print(i, j, spellType, id, spellName)
    end
end
```

Prints all pet spells.
```lua
for i = 1, HasPetSpells() do
    local spellType, id = GetSpellBookItemInfo(i, BOOKTYPE_PET)
    local spellID = bit.band(0xFFFFFF, id)
    -- not sure what the non-spell IDs are
    local spellName = spellID > 100 and GetSpellInfo(spellID) or GetSpellBookItemName(i, BOOKTYPE_PET)
    local hasActionButton = C_ActionBar.HasPetActionButtons(id)
    print(i, spellType, id, spellID, spellName, hasActionButton)
end
```