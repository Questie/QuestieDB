## Title: C_Traits.GetTreeCurrencyInfo

**Content:**
Returns the list of TraitCurrencies related to a TraitTree.
`treeCurrencyInfo = C_Traits.GetTreeCurrencyInfo(configID, treeID, excludeStagedChanges)`

**Parameters:**
- `configID`
  - *number* - For TalentTrees this will often be `C_ClassTalents.GetActiveConfigID`, this is -1 when inspecting a player. For professions, this will be `C_ProfSpecs.GetConfigIDForSkillLine`.
- `treeID`
  - *number* - For TalentTrees a class-specific TreeID, for professions `C_ProfSpecs.GetSpecTabIDsForSkillLine`.
- `excludeStagedChanges`
  - *boolean* - If true, the committed value is returned; if false, the staged value is returned instead.

**Returns:**
- `treeCurrencyInfo`
  - *TreeCurrencyInfo* - For TalentTrees, the first currency returned is for the class points, the second currency is spec points.
    - `Field`
    - `Type`
    - `Description`
    - `traitCurrencyID`
      - *number* - Can be used in e.g. `C_Traits.GetNodeCost` and `C_Traits.GetTraitCurrencyInfo`
    - `quantity`
      - *number* - How much currency is available to be used, e.g. available talent points, or profession knowledge.
    - `maxQuantity`
      - *number?* - For TalentTrees, the amount of points available at your current level.
    - `spent`
      - *number* - The amount of currency already spent on traits.