## Title: GetQuestGreenRange

**Content:**
Return for how many levels below you quests and mobs remain "green" (i.e. yield XP)
`range = GetQuestGreenRange()`

**Returns:**
- `range`
  - *number* - an integer value, currently up to 12 (at level 60)

**Usage:**
- At level 9, `GetQuestGreenRange()` returns 5
- At level 50, `GetQuestGreenRange()` returns 10