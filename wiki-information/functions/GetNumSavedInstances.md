## Title: GetNumSavedInstances

**Content:**
Returns the number of instances for which the character is locked out.
`numInstances = GetNumSavedInstances()`

**Returns:**
- `numInstances`
  - *number* - number of instances with available lockouts, 0 if none.

**Description:**
Returns the number of records that can be queried via `GetSavedInstanceInfo(...)`.
The count returned includes not just locked instances, but expired and extended lockouts as well.
The count does not include world bosses, which use `GetNumSavedWorldBosses()`.

**Reference:**
- `GetSavedInstanceInfo(...)` - drills down to a specific saved instance
- `GetNumSavedWorldBosses()` - same function as this, but for world bosses