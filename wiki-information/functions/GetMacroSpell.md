## Title: GetMacroSpell

**Content:**
Returns information about the spell a given macro is set to cast.
`id = GetMacroSpell(slot or macroName)`

**Parameters:**
- `slot`
  - *number* - The macro slot to query.
- `macroName`
  - *string* - The name of the macro to query.

**Returns:**
- `id`
  - *number* - The ability's spellId.

**Description:**
Action-bar addons use this function to display dynamic macro icons, tooltips, and glow effects. As a macro's cast sequence changes, this function indicates which will be cast next.

**Usage:**
```lua
local macroName = "MyMacro"
local index = GetMacroIndexByName(macroName)
if index then 
    local spellId = GetMacroSpell(index)
    if spellId then
        print(macroName .. " will now cast " .. GetSpellLink(spellId))
    end
end
```

**Reference:**
- Aerythlea 2018-11-14. Battle for Azeroth Addon Changes.