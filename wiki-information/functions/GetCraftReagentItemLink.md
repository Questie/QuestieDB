## Title: GetCraftReagentItemLink

**Content:**
This command returns a required reagent (as an itemLink) for a specific craftable item from the currently visible tradeskill window.
`reagentLink = GetCraftReagentItemLink(index, n)`

**Parameters:**
- `index`
  - *number* - index of the requested craft recipe, where 1 is the top-most listed recipe.
- `n`
  - *number* - index of the Nth reagent for the recipe, where 1 is the first reagent.

**Returns:**
- `reagentLink`
  - *string* - itemLink for the requested reagent.

**Description:**
If you specify an invalid index, `nil` is returned.
If there is no visible tradeskill window, `nil` is returned.