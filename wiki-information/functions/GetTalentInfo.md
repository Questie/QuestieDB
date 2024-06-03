## Title: GetTalentInfo

**Content:**
For the Dragonflight version, see Dragonflight Talent System.
For the Wrath version, see API GetTalentInfo/Wrath.
For the WoW Classic version, see API GetTalentInfo/Classic.
Returns info for the specified talent.
```lua
talentID, name, texture, selected, available, spellID, unknown, row, column, known, grantedByAura = GetTalentInfo(tier, column, specGroupIndex)
talentID, name, texture, selected, available, spellID, unknown, row, column, known, grantedByAura = GetTalentInfoByID(talentID, specGroupIndex)
talentID, name, texture, selected, available, spellID, unknown, row, column, known, grantedByAura = GetTalentInfoBySpecialization(specIndex, tier, column)
```

**Parameters:**

*GetTalentInfo:*
- `tier`
  - *number* - Talent tier from 1 to MAX_TALENT_TIERS
- `column`
  - *number* - Talent column from 1 to NUM_TALENT_COLUMNS
- `specGroupIndex`
  - *number* - Index of active specialization group (GetActiveSpecGroup)
- `isInspect`
  - *boolean?* - If non-nil, returns information based on inspectedUnit/classId.
- `inspectUnit`
  - *string? : UnitId* - Inspected unit; if nil, the selected/available return values will always be false.

*GetTalentInfoByID:*
- `talentID`
  - *number* - Talent ID.
- `specGroupIndex`
  - *number*
- `isInspect`
  - *boolean?*
- `inspectUnit`
  - *string? : UnitId*

*GetTalentInfoBySpecialization:*
- `specIndex`
  - *number* - Index of the specialization, ascending from 1 to GetNumSpecializations().
- `tier`
  - *number*
- `column`
  - *number*

**Returns:**
1. `talentID`
   - *number* - Talent ID.
2. `name`
   - *string* - Talent name.
3. `texture`
   - *number : FileID*
4. `selected`
   - *boolean* - true if the talent is chosen, false otherwise.
5. `available`
   - *boolean* - true if the talent tier is chosen, or if it is level-appropriate for the player and the player has no talents selected in that tier, false otherwise.
6. `spellID`
   - *number* - Spell ID that is added to the spellbook.
7. `unknown`
   - *any*
8. `row`
   - *number* - The row the talent is from. This will be the same as the tier argument given.
9. `column`
   - *number* - The column the talent is from. This will be the same as the column argument given.
10. `known`
    - *boolean* - true if the talent is active, false otherwise.
11. `grantedByAura`
    - *boolean* - true if the talent is granted by an aura (i.e., an effect on an item), false otherwise. Legion's Class Soul rings used this rather than selected.

**Reference:**
- `IsPlayerSpell`
- `IsSpellKnown`