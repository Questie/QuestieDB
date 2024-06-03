## Title: C_Traits.GetNodeInfo

**Content:**
Returns NodeInfo applicable to the configID you enter.
`nodeInfo = C_Traits.GetNodeInfo(configID, nodeID)`

**Parameters:**
- `configID`
  - *number* - For TalentTrees this will often be `C_ClassTalents.GetActiveConfigID`, this is -1 when inspecting a player. For professions, this will be `C_ProfSpecs.GetConfigIDForSkillLine`.
- `nodeID`
  - *number* - e.g. from `C_Traits.GetTreeNodes`

**Returns:**
- `nodeInfo`
  - *TraitNodeInfo?* - if the configID is not valid, returns nil. If information for a node cannot be retrieved for another reason, all fields are zeroed out. Most information relates to your current preview state, unless otherwise specified
    - `Field`
    - `Type`
    - `Description`
    - `ID`
      - *number* - nodeID, 0 if node information isn't available to you
    - `posX`
      - *number* - X offset relative to the top-left corner of the UI, some class talent trees have an additional global offset
    - `posY`
      - *number* - Y offset relative to the top-left corner of the UI, some class talent trees have an additional global offset
    - `flags`
      - *number* - &1: ShowMultipleIcons - generally 0 for regular nodes, 1 for choice nodes
    - `entryIDs`
      - *number* - List of entryIDs - generally there is 1 for regular nodes, 2 for choice nodes; used in `C_Traits.GetEntryInfo`
    - `entryIDsWithCommittedRanks`
      - *number* - Committed entryIDs, which can be different from the preview state. E.g. moving talents/traits around, without pressing the confirm button, will not change this value
    - `canPurchaseRank`
      - *boolean* - False if you already have the max ranks purchased / granted; true otherwise
    - `canRefundRank`
      - *boolean* - False if you purchased 0 ranks; true otherwise
    - `isAvailable`
      - *boolean* - False if not available due to Gates (i.e. you may need to spend x more points to unlock a new row of traits/talents)
    - `isVisible`
      - *boolean* - False if a node should not be shown in the UI, this generally only happens when all other info is zeroed out as well
    - `ranksPurchased`
      - *number* - Number of ranks purchased, automatically granted ranks do not count
    - `activeRank`
      - *number* - The current (preview) rank for the node - used to track if the node is maxed, or has progress; this can never be greater than maxRanks
    - `currentRank`
      - *number* - Similar to activeRank - used for tooltips and other texts; through bugs, it can be possible for this to be greater than maxRanks, seems to be the sum of GrantedRanks + PurchasedRanks
    - `activeEntry`
      - *TraitEntryRankInfo?* - The currently selected (preview) entry; if no entry is learned, regular nodes have an entry with rank 0, choice nodes have nil; the rank matches activeRank
    - `nextEntry`
      - *TraitEntryRankInfo?* - The next entry when spending a point; nil for choice nodes, or if maxed
    - `maxRanks`
      - *number* - Maximum ranks for a node, also applies to choice nodes
    - `type`
      - *Enum.TraitNodeType* - The type of node, has implications for how the API interacts with the node, and how the UI displays and interacts with the node
    - `visibleEdges`
      - *TraitOutEdgeInfo* - Outgoing connections for a node, filtered to only return edges with a visible target node - the UI displays these as arrows pointing towards other nodes
    - `meetsEdgeRequirements`
      - *boolean* - True if incoming edge requirements are met (see `Enum.TraitEdgeType`), or if there are no incoming edges (i.e. the initial nodes in a tree), false otherwise - the UI uses this to disable the node button
    - `groupIDs`
      - *number* - TraitNodeGroups are not generally exposed through the API, but they relate to how Gates work, TraitCurrency costs, TraitConditions, and possibly more
    - `conditionIDs`
      - *number* - Can be used for `C_Traits.GetConditionInfo` conditions can grant ranks, limit visibility to specs, set Gate requirements, and more
    - `isCascadeRepurchasable`
      - *boolean* - If true, you can shift-click to purchase back nodes that you previously had selected, but were deselected because you unlearned something higher up in the tree
    - `cascadeRepurchaseEntryID`
      - *number?* - TraitEntryRankInfo
        - `Field`
        - `Type`
        - `Description`
        - `entryID`
          - *number* - As used in `C_Traits.GetEntryInfo`
        - `rank`
          - *number* - May be 0 for single choice nodes

**Enum.TraitNodeType**
- `Value`
- `Field`
- `Description`
- `0`
  - Single - The most common type, includes multi-rank traits and single-rank traits
- `1`
  - Tiered - Unsure where this is used, but seems to result in the node and nodeEntry costs being combined in some way
- `2`
  - Selection - Applies to all choice nodes, where you can select between multiple (generally 2) options

**TraitOutEdgeInfo**
- `Field`
- `Type`
- `Description`
- `targetNode`
  - *number* - The target nodeID
- `type`
  - *Enum.TraitEdgeType* - Has implications on how meetsEdgeRequirements is calculated
- `visualStyle`
  - *Enum.TraitEdgeVisualStyle* - Defines how the UI displays the edge
- `isActive`
  - *boolean* - Active edges generally have a different visual, and meetsEdgeRequirements is calculated based on active incoming edges

**Enum.TraitEdgeType**
- `Value`
- `Field`
- `Description`
- `0`
  - VisualOnly - Simply results in a visual connection, has no impact on edge requirements
- `1`
  - DeprecatedRankConnection - Presumably deprecated, and can be ignored
- `2`
  - SufficientForAvailability - If any incoming edge of this type is active, all edges of this type pass the edge requirements
- `3`
  - RequiredForAvailability - All incoming edges of this type must be active to pass the edge requirements
- `4`
  - MutuallyExclusive - No edges of this type currently exist, but the UI does show a different visual effect - presumably, only 1 incoming edge if this type is allowed to be active, to pass the edge requirements
- `5`
  - DeprecatedSelectionOption - Presumably deprecated, and can be ignored

**Enum.TraitEdgeVisualStyle**
- `Value`
- `Field`
- `Description`
- `0`
  - None - No edges of this type exist, presumably, they would not display in the UI
- `1`
  - Straight - A simple straight arrow between nodes