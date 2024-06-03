## Title: C_Traits.CanPurchaseRank

**Content:**
Checks whether a node entry is purchasable.
`canPurchase = C_Traits.CanPurchaseRank(configID, nodeID, nodeEntryID)`

**Parameters:**
- `configID`
  - *number*
- `nodeID`
  - *number*
- `nodeEntryID`
  - *number*

**Returns:**
- `canPurchase`
  - *boolean*

**Description:**
There is generally little value in calling this API, instead, you can call `C_Traits.PurchaseRank` or `C_Traits.SetSelection` directly, and check their return values.
Currently, the default UI only uses this API for profession nodes, to check whether unlocking a node, or spending points on the node is possible, and not for generic talents or class talents.