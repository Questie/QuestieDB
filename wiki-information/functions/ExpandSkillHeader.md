## Title: ExpandSkillHeader

**Content:**
Expands a header in the skills window.
`ExpandSkillHeader(index)`

**Parameters:**
- `index`
  - *number* - The index of a line in the skills window. Index 0 ("All") will expand all headers.

**Reference:**
- `GetSkillLineInfo()`

**Example Usage:**
```lua
-- Expanding all skill headers
ExpandSkillHeader(0)

-- Expanding a specific skill header by index
local skillIndex = 3
ExpandSkillHeader(skillIndex)
```

**Common Addon Usage:**
Many addons that manage or display profession and skill information, such as TradeSkillMaster or Skillet, may use this function to ensure all skill headers are expanded before processing or displaying skill data.