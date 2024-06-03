## Title: C_Traits.ResetTreeByCurrency

**Content:**
Resets the tree, refunding any purchased traits where possible, but only if the trait costs the specified traitCurrencyID.
`success = C_Traits.ResetTreeByCurrency(configID, treeID, traitCurrencyID)`

**Parameters:**
- `configID`
  - *number*
- `treeID`
  - *number*
- `traitCurrencyID`
  - *number*

**Returns:**
- `success`
  - *boolean*

**Description:**
This API is used to reset only class talents, or only spec talents, rather than resetting the entire tree with `C_Traits.ResetTree`.