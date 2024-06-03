## Title: GetSpellCritChance

**Content:**
Returns the critical hit chance for the specified spell school.
`critChance = GetSpellCritChance(school)`

**Parameters:**
- `school`
  - *number* - the spell school to retrieve the crit chance for. Note: does not seem to be in Blizzard API Documentation.
    - 1 for Physical
    - 2 for Holy
    - 3 for Fire
    - 4 for Nature
    - 5 for Frost
    - 6 for Shadow
    - 7 for Arcane

**Returns:**
- `critChance`
  - *number* - An unformatted floating point figure representing the critical hit chance for the specified school.

**Usage:**
The following function, called with no arguments, will return the same spell crit value as shown on the Character pane of the default UI. The figure returned is formatted as a floating-point figure out to two decimal places.
```lua
function GetRealSpellCrit()
  local holySchool = 2;
  local minCrit = GetSpellCritChance(holySchool);
  local spellCrit;
  this.spellCrit = {};
  this.spellCrit = minCrit;
  for i = (holySchool + 1), 7 do
    spellCrit = GetSpellCritChance(i);
    minCrit = min(minCrit, spellCrit);
    this.spellCrit = spellCrit;
  end
  minCrit = format("%.2f%%", minCrit);
  return minCrit;
end
```
The above function is essentially a straight copy of the function from the Paper Doll LUA file in the default UI.