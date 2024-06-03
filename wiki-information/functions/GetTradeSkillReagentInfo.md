## Title: GetTradeSkillReagentInfo

**Content:**
Returns information on reagents for the specified trade skill.
`reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(tradeSkillRecipeId, reagentId)`

**Parameters:**
- `tradeSkillRecipeId`
  - The Id of the tradeskill recipe
- `reagentId`
  - The Id of the reagent (from 1 to x, where x is the result of calling GetTradeSkillNumReagents)

**Returns:**
- `reagentName`
  - *string* - The name of the reagent.
- `reagentTexture`
  - *string* - The texture for the reagent's icon.
- `reagentCount`
  - *number* - The quantity of this reagent required to make one of these items.
- `playerReagentCount`
  - *number* - The quantity of this reagent in the player's inventory.

**Usage:**
```lua
local numReagents = GetTradeSkillNumReagents(id);
local totalReagents = 0;
for i=1, numReagents, 1 do
  local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i);
  totalReagents = totalReagents + reagentCount;
end;
```

**Miscellaneous:**
- **Result:**
  - Calculates the total number of items required by the recipe.