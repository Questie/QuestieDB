## Title: GetTradeSkillInfo

**Content:**
Retrieves information about a specific trade skill.
`skillName, skillType, numAvailable, isExpanded, altVerb, numSkillUps, indentLevel, showProgressBar, currentRank, maxRank, startingRank = GetTradeSkillInfo(skillIndex)`

**Parameters:**
- `skillIndex`
  - *number* - The id of the skill you want to query.

**Returns:**
- `skillName`
  - *string* - The name of the skill, e.g. "Copper Breastplate" or "Daggers", if the skillIndex references a heading.
- `skillType`
  - *string* - "header", if the skillIndex references a heading; "subheader", if the skillIndex references a subheader for things like the cooking specialties; or a string indicating the difficulty to craft the item ("trivial", "easy", "medium", "optimal", "difficult").
- `numAvailable`
  - *number* - The number of items the player can craft with their available trade goods.
- `isExpanded`
  - *boolean* - Returns if the header of the skillIndex is expanded in the crafting window or not.
- `altVerb`
  - *string* - If not nil, a verb other than "Create" which describes the trade skill action (i.e., for Enchanting, this returns "Enchant"). If nil, the expected verb is "Create."
- `numSkillUps`
  - *number* - The number of skill ups that the player can receive by crafting this item.
- `indentLevel`
  - *number* - 0 or 1, indicates whether this skill should be indented beneath its header. Used for specialty subheaders and their recipes.
- `showProgressBar`
  - *boolean* - Indicates if a sub-progress bar must be displayed with the specialty current and max ranks. In the normal UI, those values are only shown when the mouse is over the sub-header.
- `currentRank`
  - *number* - The current rank for the specialty if `showProgressBar` is true.
- `maxRank`
  - *number* - The maximum rank for the specialty if `showProgressBar` is true.
- `startingRank`
  - *number* - The starting rank where the specialty is available. It is used as the starting value of the progress bar.

**Usage:**
```lua
local name, type;
for i = 1, GetNumTradeSkills() do
  name, type, _, _, _, _ = GetTradeSkillInfo(i);
  if (name and type ~= "header") then
    DEFAULT_CHAT_FRAME:AddMessage("Found: " .. name);
  end
end
```

**Miscellaneous:**
Result:

Displays all items the player is able to craft in the chat windows.