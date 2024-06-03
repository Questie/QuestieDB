## Title: GetCraftSkillLine

**Content:**
This command tells the caller which, if any, crafting window is currently open.
`currentCraftingWindow = GetCraftSkillLine(n)`

**Parameters:**
- `n`
  - *number* - Not sure how this is used, but any number greater than zero seems to behave identically. Passing zero always results in a nil return value.

**Returns:**
- `currentCraftingWindow`
  - *string* - The name of the currently opened crafting window, or nil if no crafting window is open. This will be one of "Enchanting" or "Beast Training".

**Description:**
This function is not quite the same as `GetCraftDisplaySkillLine()`. The latter returns nil in case the Beast Training window is open, while the current function returns "Beast Training".