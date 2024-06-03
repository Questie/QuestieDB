## Title: FillLocalizedClassList

**Content:**
Fills a table with localized male or female class names.
`t = FillLocalizedClassList(tbl, isFemale)`

**Parameters:**
- `classTable`
  - *table* - The table you want to be filled with the data.
- `isFemale`
  - *boolean?* - If the table should be filled with female class names.

**Returns:**
- `classTable`
  - *table* - The same table argument you passed.

**Usage:**
Prints all female class names.
```lua
local t = {}
FillLocalizedClassList(t, true)
for classFile, name in pairs(t) do
    print(classFile, name)
end
```

FrameXML already populates the `LOCALIZED_CLASS_NAMES_MALE` and `LOCALIZED_CLASS_NAMES_FEMALE` globals.
```lua
/dump LOCALIZED_CLASS_NAMES_MALE, LOCALIZED_CLASS_NAMES_FEMALE
-- on frFR locale
-- Male class names
= {
    DEATHKNIGHT = "Chevalier de la mort",
    DEMONHUNTER = "Chasseur de démons",
    DRUID = "Druide",
    EVOKER = "Évocateur",
    HUNTER = "Chasseur",
    MAGE = "Mage",
    MONK = "Moine",
    PALADIN = "Paladin",
    PRIEST = "Prêtre",
    ROGUE = "Voleur",
    SHAMAN = "Chaman",
    WARLOCK = "Démoniste",
    WARRIOR = "Guerrier",
},
-- Female class names
= {
    DEATHKNIGHT = "Chevalier de la mort",
    DEMONHUNTER = "Chasseuse de démons",
    DRUID = "Druidesse",
    EVOKER = "Évocatrice",
    HUNTER = "Chasseresse",
    MAGE = "Mage",
    MONK = "Moniale",
    PALADIN = "Paladin",
    PRIEST = "Prêtresse",
    ROGUE = "Voleuse",
    SHAMAN = "Chamane",
    WARLOCK = "Démoniste",
    WARRIOR = "Guerrière",
}
```