## Title: LearnTalent

**Content:**
Learns the specified talent.
`success = LearnTalent(talentID)`

**Parameters:**
- `talentID`
  - *number*

**Returns:**
- `success`
  - *boolean* - Returns false when e.g. in combat.

**Usage:**
Learns holy priest's talent.
```lua
/run LearnTalent(19753)
```

**Reference:**
- `LearnPvpTalent()`