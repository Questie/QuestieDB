## Title: C_Traits.PurchaseRank

**Content:**
Attempt to purchase a rank. Changes are not applied until they are committed (through `C_Traits.CommitConfig` or `C_ClassTalents.CommitConfig`).
`success = C_Traits.PurchaseRank(configID, nodeID)`

**Parameters:**
- `configID`
  - *number*
- `nodeID`
  - *number*

**Returns:**
- `success`
  - *boolean*

**Reference:**
`C_Traits.SetSelection` to purchase/select a Selection node. `C_Traits.PurchaseRank` should not be used with selection nodes (aka choice nodes).