## Title: GetTradeSkillReagentItemLink

**Content:**
Gets the link string for a trade skill reagent.
`link = GetTradeSkillReagentItemLink(skillId, reagentId)`

**Parameters:**
- `skillId`
  - *number* - The Id specifying which trade skill's reagent to link.
- `reagentId`
  - *number* - The Id specifying which of the skill's reagents to link.

**Returns:**
- `link`
  - *string* - An item link string (color coded with href) which can be included in chat messages to represent the reagent required for the trade skill.

**Description:**
This function is broken on 5.2.0 build 16650 and always returns nil.