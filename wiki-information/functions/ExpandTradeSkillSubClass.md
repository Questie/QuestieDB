## Title: ExpandTradeSkillSubClass

**Content:**
Expands a header within a tradeskill window.
`ExpandTradeSkillSubClass(index)`

**Parameters:**
- `index`
  - *number* - index within the tradeskill window

**Reference:**
It is unknown whether an event triggers.

**Usage:**
```lua
_, skillType, _, isExpanded, _, _ = GetTradeSkillInfo(skillIndex)
for index = GetNumTradeSkills(), 1, -1 do
  if skillType == "header" then
    ExpandTradeSkillSubClass(index)
  end
end
```

**Result:**
All your currently-listed subclasses will be expanded. Subclasses that are folded within another will remain at their former state, collapsed or expanded.

**Description:**
No error is generated when already isExpanded.
An error is generated when the skillType ~= "header": Bad skill line in ExpandTradeSkillSubClass.