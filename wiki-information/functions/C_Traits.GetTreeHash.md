## Title: C_Traits.GetTreeHash

**Content:**
Get a checksum of the specified tree's structure.
`result = C_Traits.GetTreeHash(treeID)`

**Parameters:**
- `treeID`
  - *number*

**Returns:**
- `result`
  - *number* - 16 numbers between 1 and 256

**Description:**
The default UI uses this checksum to check whether a talent string was created based on a different talent layout. The hash can be expected to change if any talents are changed.
It's important to realize that the hash does not cover any player choices; its only purpose is to determine if a talent string corresponds to a valid tree.
Third-party websites will use a table with 16 zeroes instead, to disable this specific validation step.