## Title: GetBattlefieldInstanceInfo

**Content:**
Returns the battlefield instance ID for an index in the battlemaster listing.
`instanceID = GetBattlefieldInstanceInfo(index)`

**Parameters:**
- `index`
  - *number* - The battlefield instance index, from 1 to `GetNumBattlefields()` when speaking to the battlemaster.

**Returns:**
- `instanceID`
  - *number* - The battlefield instance ID. For example, the ID in "Warsong Gulch 2".