## Title: GetTrainerServiceSkillReq

**Content:**
Returns the name of the required skill and the amount needed in that skill.
`skillName, skillLevel, hasReq = GetTrainerServiceSkillReq(index)`

**Parameters:**
- `index`
  - the number of the selection in the trainer window

**Returns:**
- `skillName`
  - The name of the skill.
- `skillLevel`
  - The required level needed for the skill.
- `hasReq`
  - 1 or nil. Seems to be 1 for skills that you cannot learn, nil for skills you have learned already.

**Usage:**
```lua
local selection = GetTrainerSelectionIndex()

local skillName, skillAmt = GetTrainerServiceSkillReq(selection)
DEFAULT_CHAT_FRAME:AddMessage('Skill Name: ' .. skillName)
DEFAULT_CHAT_FRAME:AddMessage('Skill Amount Required: ' .. skillLevel)
```
If you had an engineering trainer open, with a skill you knew already the output would be:
```
Skill Name: Engineering
Skill Amount Required: 375
```