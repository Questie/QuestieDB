## Title: C_Traits.SetSelection

**Content:**
Attempt to change the current selection for a selection node (aka choice node). Changes are not applied until they are committed (through `C_Traits.CommitConfig` or `C_ClassTalents.CommitConfig`).
`success = C_Traits.SetSelection(configID, nodeID)`

**Parameters:**
- `configID`
  - *number*
- `nodeID`
  - *number*
- `nodeEntryID`
  - *number?* - pass nil to unselect the node, effectively the equivalent of `C_Traits.RefundRank`.
- `clearEdges`
  - *boolean?* - if true, unselecting the node will refund all talents that no longer meet their requirements

**Returns:**
- `success`
  - *boolean*

**Description:**
This API can be used to set the initial selection, change a selection, or unselect a selection node (aka choice node). Passing `clearEdges = true`, and unselecting a selection node, may result in other talents being refunded, e.g., if you no longer meet a gate criterion, or if the selection node is the only path to a set of selected talents.
You should not use the `C_Traits.PurchaseRank` or `C_Traits.RefundRank` APIs on selection nodes. `C_Traits.SetSelection` is the only API used to modify selection node choices.