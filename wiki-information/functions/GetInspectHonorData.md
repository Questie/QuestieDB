## Title: GetInspectHonorData

**Content:**
Returns honor info for the inspected player unit.
`todayHK, todayHonor, yesterdayHK, yesterdayHonor, lifetimeHK, lifetimeRank = GetInspectHonorData()`

**Returns:**
- `todayHK`
  - *number* - Honor kills made today.
- `todayHonor`
  - *number* - Honor rewarded today.
- `yesterdayHK`
  - *number* - Amount of honor kills made yesterday.
- `yesterdayHonor`
  - *number* - The honor rewarded yesterday.
- `lifetimeHK`
  - *number* - Total lifetime honor kills.
- `lifetimeRank`
  - *number* - Highest PvP rank ever attained.

**Description:**
Before this function can return any information, `NotifyInspect(unit)` must be called first, followed by a call to the `RequestInspectHonorData` function.