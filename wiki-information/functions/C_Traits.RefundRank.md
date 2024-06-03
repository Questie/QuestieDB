## Title: C_Traits.RefundRank

**Content:**
Attempt to refund a rank. Changes are not applied until they are committed (through `C_Traits.CommitConfig` or `C_ClassTalents.CommitConfig`).
`success = C_Traits.RefundRank(configID, nodeID)`

**Parameters:**
- `configID`
  - *number*
- `nodeID`
  - *number*
- `clearEdges`
  - *boolean?* - if true, refunding the talent will refund all talents that no longer meet their requirements

**Returns:**
- `success`
  - *boolean*

**Description:**
If you pass `clearEdges = true`, it's possible that refunding a node results in other nodes being refunded too. E.g. if you no longer meet a gate criterium, or if the node is the only path to a set of selected talents.

**Reference:**
- `C_Traits.SetSelection` to unselect a Selection node. `C_Traits.RefundRank` must not be used with selection nodes (aka choice nodes).