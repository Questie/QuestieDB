## Title: GetNumSkillLines

**Content:**
Returns the number of skill lines in the skill window, including headers.
`numSkills = GetNumSkillLines()`

**Returns:**
- `numSkills`
  - *number*

**Reference:**
- `GetSkillLineInfo()`

**Example Usage:**
This function can be used to iterate through all skill lines in the skill window. For example, you might use it in a loop to gather information about each skill line:

```lua
local numSkills = GetNumSkillLines()
for i = 1, numSkills do
    local skillName, isHeader = GetSkillLineInfo(i)
    if not isHeader then
        print("Skill:", skillName)
    end
end
```

**Addons:**
Many addons that manage or display profession and skill information, such as TradeSkillMaster, use this function to gather data about the player's skills.