## Title: GetCraftNumReagents

**Content:**
This command tells the caller how many reagents are required for said craft.
`numRequiredReagents = GetCraftNumReagents(index)`

**Parameters:**
- `index`
  - *Numeric* - Number from 1 to X, where X is the total number of possible crafts.

**Returns:**
- `numRequiredReagents`
  - *Integer* - This is the number of required reagents for said craft. For example, 4 (for any craft that requires 4 reagents to perform).