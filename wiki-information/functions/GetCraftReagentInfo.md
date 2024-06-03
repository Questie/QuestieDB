## Title: GetCraftReagentInfo

**Content:**
This command tells the caller the name of the reagent, path to the used texture, number of required reagents, and number of said reagents that the caller currently has in their bags.
`name, texturePath, numRequired, numHave = GetCraftReagentInfo(index, n)`

**Parameters:**
- `index`
  - *number* - starting at 1 going down to X number of possible crafts, where 1 is the top-most listed craft.
- `n`
  - *number* - starting at 1 to X, where X is the total number of reagents said craft requires.

**Returns:**
- `name`
  - Name of the reagent required. e.g., "Large Brilliant Shard"
- `texturePath`
  - Path to the required item texture. e.g., "Interface\\Icons\\INV_Enchant_ShardBrilliantLarge"
- `numRequired`
  - *number* - Number of total required reagents.
- `numHave`
  - *number* - Number of total required reagents that the user has on them currently.