## Title: GetSpellBookItemName

**Content:**
Returns the name of a spellbook item.
```lua
spellName, spellSubName, spellID = GetSpellBookItemName(spellName)
spellName, spellSubName, spellID = GetSpellBookItemName(index, bookType)
```

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
- `spellName`
  - *string* - Name of the spell as it appears in the spell book, e.g. "Lesser Heal"
- `spellSubName`
  - *string* - The spell rank or sub type, e.g. "Grand Master", "Racial Passive". This can be an empty string. Note: for the Enchanting trade skill at rank Apprentice, the returned string contains a trailing space, i.e. "Apprentice ". This might be the case for other trade skills and ranks also. Not readily available on function call, see `SpellMixin:ContinueOnSpellLoad()`
- `spellID`
  - *number*

**Description:**
- **Related API**
  - `GetSpellBookItemInfo`
- This function will return nested flyout spells, but the names returned may not be functional (a hunter will see "Call <petname>" instead of "Call Pet 1" but "/cast Call <petname>" will not function in a macro or from the command line). Use care with the results returned.
- Spell book information is first available after the `SPELLS_CHANGED` event fires.

**Usage:**
Prints all spells in the spellbook for the player, except the profession tab ones.
```lua
for i = 1, GetNumSpellTabs() do
    local offset, numSlots = select(3, GetSpellTabInfo(i))
    for j = offset+1, offset+numSlots do
        print(i, j, GetSpellBookItemName(j, BOOKTYPE_SPELL))
    end
end
```

Prints the spells shown in the profession tab.
```lua
for _, i in pairs{GetProfessions()} do
    local offset, numSlots = select(3, GetSpellTabInfo(i))
    for j = offset+1, offset+numSlots do
        print(i, j, GetSpellBookItemName(j, BOOKTYPE_SPELL))
    end
end
-- Example output:
-- 7, 126, "Tailoring", "", 3908
-- 8, 128, "Engineering", "", 4036
-- 6, 122, "Cooking", "", 2550
-- 6, 123, "Cooking Fire", "", 81
```

Prints the spells shown in the pet tab.
```lua
local numSpells, petToken = HasPetSpells() -- nil if pet does not have spellbook, 'petToken' will usually be 'PET'
for i=1, numSpells do
    local petSpellName, petSubType, unmaskedSpellId = GetSpellBookItemName(i, "pet")
    print("petSpellName", petSpellName) -- like "Dash"
    print("petSubType", petSubType) -- like "Basic Ability" or "Pet Stance"
    print("unmaskedId", unmaskedSpellId) -- don't have to apply the 0xFFFFFF mask like you do for GetSpellBookItemInfo
end
```

Note that not all spells available from the API are shown in the spellbook.
```lua
local i = 1
while GetSpellBookItemName(i, BOOKTYPE_SPELL) do
    print(i, GetSpellBookItemName(i, BOOKTYPE_SPELL))
    i = i + 1
end
```