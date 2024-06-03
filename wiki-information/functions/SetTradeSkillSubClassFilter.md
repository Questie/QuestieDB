## Title: SetTradeSkillSubClassFilter

**Content:**
Sets the subclass filter.
`SetTradeSkillSubClassFilter(slotIndex, onOff{, exclusive})`

**Parameters:**
- `slotIndex`
  - The index of the specific slot
- `onOff`
  - On = 1, Off = 0
- `exclusive` (Optional)
  - Sets if the slot is the only slot to be selected. If not set it's handled as Off. On = 1, Off = 0

**Usage:**
Sets the filter to select slotIndex 3 and 5. First slotIndex have to be exclusive enabled.
```lua
SetTradeSkillSubClassFilter(3, 1, 1);
SetTradeSkillSubClassFilter(5, 1);
```

**Reference:**
- `GetTradeSkillSubClassFilter`