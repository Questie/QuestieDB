## Title: GetTradeSkillSelectionIndex

**Content:**
Returns the index of the currently selected trade skill.
`local tradeSkillIndex = GetTradeSkillSelectionIndex()`

**Returns:**
- `tradeSkillIndex`
  - *number* - The index of the currently selected trade skill, or 0 if none selected.

**Usage:**
```lua
if ( GetTradeSkillSelectionIndex() > 1 ) then
  TradeSkillFrame_SetSelection(GetTradeSkillSelectionIndex());
else
  if ( GetNumTradeSkills() > 0 ) then
    TradeSkillFrame_SetSelection(GetFirstTradeSkill());
  end;
end;
```