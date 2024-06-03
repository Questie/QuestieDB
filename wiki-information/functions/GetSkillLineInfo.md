## Title: GetSkillLineInfo

**Content:**
Returns information on a skill line/header.
```lua
skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDescription = GetSkillLineInfo(index)
```

**Parameters:**
- `index`
  - *number* - The index of a line in the skills window, can be a header or skill line. Indices can change depending on collapsed/expanded headers.

**Returns:**
1. `skillName`
   - *string* - Name of the skill line.
2. `header`
   - *number* - Returns 1 if the line is a header, nil otherwise.
3. `isExpanded`
   - *number* - Returns 1 if the line is a header and expanded, nil otherwise.
4. `skillRank`
   - *number* - The current rank for the skill, 0 if not applicable.
5. `numTempPoints`
   - *number* - Temporary points for the current skill.
6. `skillModifier`
   - *number* - Skill modifier value for the current skill.
7. `skillMaxRank`
   - *number* - The maximum rank for the current skill. If this is 1 the skill is a proficiency.
8. `isAbandonable`
   - *number* - Returns 1 if this skill can be unlearned, nil otherwise.
9. `stepCost`
   - *number* - Returns 1 if skill can be learned, nil otherwise.
10. `rankCost`
    - *number* - Returns 1 if skill can be trained, nil otherwise.
11. `minLevel`
    - *number* - Minimum level required to learn this skill.
12. `skillCostType`
    - *number*
13. `skillDescription`
    - *string* - Localized skill description text

**Usage:**
Prints the player's skill lines.
```lua
/run for i = 1, GetNumSkillLines() do print(i, GetSkillLineInfo(i)) end
```