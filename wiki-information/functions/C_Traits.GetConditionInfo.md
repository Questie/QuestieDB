## Title: C_Traits.GetConditionInfo

**Content:**
Returns conditionInfo applicable to the configID you enter
`condInfo = C_Traits.GetConditionInfo(configID, condID)`

**Parameters:**
- `configID`
  - *number* - For TalentTrees this will often be `C_ClassTalents.GetActiveConfigID`, this is -1 when inspecting a player. For professions, this will be `C_ProfSpecs.GetConfigIDForSkillLine`.
- `condID`
  - *number* - trait conditionId as found in e.g. `C_Traits.GetNodeInfo` or `C_Traits.GetEntryInfo`

**Returns:**
- `condInfo`
  - *TraitCondInfo* - returns nil if no info is found
    - `Field`
    - `Type`
    - `Description`
    - `condID`
      - *number* - as supplied in the arguments
    - `ranksGranted`
      - *number?* - if the condition is met, this number of ranks is granted to applicable nodes
    - `isAlwaysMet`
      - *boolean* - generally false, no TraitConditions are currently used where this is true
    - `isMet`
      - *boolean* - whether the condition is met
    - `isGate`
      - *boolean* - whether the condition is a Gate - this generally only impacts tooltips and class talent trees
    - `questID`
      - *number?* - no conditions seem to currently exist with this value - presumably these would require a quest to be completed; or, less likely, require the quest to be in your questlog
    - `achievementID`
      - *number?* - condition is met if the achievement has been earned
    - `specSetID`
      - *number?* - condition is met if your spec matches any spec from the specified specSet (see `C_SpecializationInfo.GetSpecIDs`)
    - `playerLevel`
      - *number?* - condition is met if you are at or above the specified level
    - `traitCurrencyID`
      - *number?* - combined with spentAmountRequired - matches the ID in TraitCurrencyCost (see `C_Traits.GetNodeCost`, and `C_Traits.GetTreeCurrencyInfo`)
    - `spentAmountRequired`
      - *number?* - condition is met if you spent the specified amount in the specified traitCurrency
    - `tooltipFormat`
      - *string?* - a tooltip string, potentially with placeholders suitable for `string.format`, which can be displayed if the condition isn't met
    - `tooltipText`
      - *string?* - Blizzard_SharedTalentUI adds this data to the response manually, see `Blizzard_SharedTalentUtil.lua`; the data is based on tooltipFormat, and adds quest/achievement/spec/level/spending info

**Description:**
Trait conditions have specific types. These types are not exposed in the API, but an enum is documented (`Enum.TraitConditionType`).
Conditions broadly fall into 2 categories, 'Friendly' and 'NotFriendly'. Friendly conditions give benefits, while NotFriendly conditions impose restrictions.

**Enum.TraitConditionType:**
- `Value`
- `Field`
- `Category`
- `Description`
  - `0`
    - `Available`
    - `NotFriendly`
    - Nodes are available by default, but if any condition of this type is not met, then the node is not available - e.g. Gates are implemented this way
  - `1`
    - `Visible`
    - `NotFriendly`
    - Nodes are visible by default, but if any condition of this type is not met, then the node is not visible - e.g. if a condition requires a specific spec, the node will be hidden
  - `2`
    - `Granted`
    - `Friendly`
    - Grants rank(s) for the relevant node
  - `3`
    - `Increased`
    - `Friendly`
    - No condition of this type currently exists, presumably they work similar to Granted