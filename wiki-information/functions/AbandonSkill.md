## Title: AbandonSkill

**Content:**
The player abandons a skill.
`AbandonSkill(skillLineID)`

**Parameters:**
- `skillLineID`
  - *number* - The Skill Line ID (can be found with API `GetProfessionInfo()`)

**Usage:**
```lua
local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();
local skillLineID = select(7, GetProfessionInfo(prof1));
AbandonSkill(skillLineID);
```

**Miscellaneous:**
The player abandons a skill.
**CAUTION:** There is no confirmation dialog for this action. Use with care.