## Title: C_Traits.GetTreeNodes

**Content:**
Returns a list of nodeIDs for a given treeID. For talent trees, this contains nodes for all specializations of the tree's class.
`nodeIDs = C_Traits.GetTreeNodes(treeID)`

**Parameters:**
- `treeID`
  - *number* - e.g. from `C_Traits.GetConfigInfo`

**Returns:**
- `nodeIDs`
  - *number* - list of nodeIDs in ascending order, can be used in `C_Traits.GetNodeInfo`

**Example Usage:**
This function can be used to retrieve all node IDs for a specific talent tree, which can then be further queried for detailed node information using `C_Traits.GetNodeInfo`.

**Addons:**
Large addons like WeakAuras might use this function to dynamically display talent tree information and track changes in a player's talent configuration.