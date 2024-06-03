## Title: C_Traits.GetConfigInfo

**Content:**
Needs summary.
`configInfo = C_Traits.GetConfigInfo(configID)`

**Parameters:**
- `configID`
  - *number* - For TalentTrees this will often be `C_ClassTalents.GetActiveConfigID`, this is -1 when inspecting a player. For professions, this will be `C_ProfSpecs.GetConfigIDForSkillLine`.

**Returns:**
- `configInfo`
  - *TraitConfigInfo*
    - `Field`
    - `Type`
    - `Description`
    - `ID`
      - *number* - ConfigID
    - `type`
      - *Enum.TraitConfigType*
    - `name`
      - *string* - E.g. talent loadout name
    - `treeIDs`
      - *number* - Can be used in e.g. `C_Traits.GetTreeNodes` or `C_Traits.GetTreeInfo`
    - `usesSharedActionBars`
      - *boolean* - Whether the talent loadout uses shared/global action bar setup, or loadout specific setup

**Enum.TraitConfigType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Invalid
  - `1`
    - Combat
    - Talent Tree
  - `2`
    - Profession
    - Profession Specialization
  - `3`
    - Generic
    - E.g. Dragon Riding talents