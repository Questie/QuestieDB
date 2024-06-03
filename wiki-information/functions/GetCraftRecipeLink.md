## Title: GetCraftRecipeLink

**Content:**
Returns the EnchantLink for a craft.
`link = GetCraftRecipeLink(index)`

**Parameters:**
- `index`
  - *number* - The index of the item in the current active trade skill.

**Returns:**
- `link`
  - *string* - An EnchantLink (color coded with href) which can be included in chat messages to show the reagents and the items the craft creates.

**Description:**
This function works with the trade skill which is currently active and only the trade skills that use the CraftFrame, not the TradeSkillFrame. Initially, there is no active trade skill. A trade skill becomes active when a trade skill window is opened, for instance.
Note that not all trade skills will change the active trade skill for this function. At the moment, only enchanting and hunter's train-pet window use CraftFrame. Use `GetTradeSkillRecipeLink` for the other professions.