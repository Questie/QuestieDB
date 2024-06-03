## Title: GetSpellTabInfo

**Content:**
Returns info for the specified spellbook tab.
`name, texture, offset, numSlots, isGuild, offspecID = GetSpellTabInfo(tabIndex)`

**Parameters:**
- `tabIndex`
  - *number* - The index of the tab, ascending from 1.

**Returns:**
- `name`
  - *string* - The name of the spell line (General, Shadow, Fury, etc.)
- `texture`
  - *string* - The texture path for the spell line's icon
- `offset`
  - *number* - Number of spell book entries before this tab (one less than index of the first spell book item in this tab)
- `numSlots`
  - *number* - The number of spell entries in this tab.
- `isGuild`
  - *boolean* - true for Guild Perks, false otherwise
- `offspecID`
  - *number* - 0 if the tab contains spells you can cast (general/specialization/trade skill/etc); or specialization ID of the specialization this tab is showing the spells of.

**Description:**
GetNumSpellTabs returns the number of class-skill tabs available to your character.
Due to flyouts, more spellbook item indices may be used by a tab than suggested by the offset/numEntries values.
Professions are tabs, too: GetProfessions returns tab indices that contain profession spells, beyond the range specified by GetNumSpellTabs.

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
    local petSpellName, petSubType, unmaskedSpellId = GetSpellBookItemName(i,"pet")
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