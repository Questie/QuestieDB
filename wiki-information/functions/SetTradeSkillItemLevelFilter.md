## Title: SetTradeSkillItemLevelFilter

**Content:**
Sets a filter on the open recipe list window based on minimum level to use.
`nil = SetTradeSkillItemLevelFilter(minLevel, maxLevel)`

**Parameters:**
- `minLevel`
  - *number* - minimum level to pass filter
- `maxLevel`
  - *number* - maximum level to pass filter

**Usage:**
```lua
CloseTradeSkill();
CastSpellByName("Alchemy");
SetTradeSkillItemLevelFilter(35, 36);
minLevel, maxLevel = GetTradeSkillItemLevelFilter();
print(type(minLevel), minLevel, type(maxLevel), maxLevel)
-- Result
-- number 35 number 36
-- And the recipe list window will be filtered thus:
-- Elixir
-- Elixir of Detect Undead
-- Elixir of Greater Water Breathing
-- Potion
-- Dreamless Sleep Potion
-- Superior Healing Potion
-- Miscellaneous
-- Philosopher's Stone
-- Each of these items require level 35 to use except the Elixir of Detect Undead which requires level 36.
```

**Description:**
Opening a new tradeskill window resets the filter to 0, 0. Closing and re-opening the same tradeskill's window does not reset the filter.
- `minLevel`
  - 0 removes the lower end of the filter.
  - -1 seems to do nothing.
  - 1 for Inscription filters out inks, and all First Aid skills.
- `maxLevel`
  - 0 removes the higher end of the filter.
  - -1 seems to filter everything out.