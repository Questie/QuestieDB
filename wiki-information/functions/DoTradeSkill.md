## Title: DoTradeSkill

**Content:**
Performs the tradeskill a specified number of times.
`DoTradeSkill(index, repeat)`

**Parameters:**
- `index`
  - *number* - The index of the tradeskill recipe.
- `repeat`
  - *number* - The number of times to repeat the creation of the specified recipe.

**Example Usage:**
```lua
-- Example: Crafting 5 items of the first recipe in the tradeskill window
DoTradeSkill(1, 5)
```

**Description:**
The `DoTradeSkill` function is used to automate the crafting process in World of Warcraft. By specifying the index of the tradeskill recipe and the number of times to repeat the action, players can efficiently craft multiple items without manual intervention.

**Usage in Addons:**
Many large addons, such as TradeSkillMaster (TSM), use `DoTradeSkill` to automate crafting processes. TSM, for example, allows players to queue up multiple items to be crafted and then uses this function to process the queue, making it easier to manage large-scale crafting operations.