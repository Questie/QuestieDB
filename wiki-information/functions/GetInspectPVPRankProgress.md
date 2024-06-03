## Title: GetInspectPVPRankProgress

**Content:**
Gets the inspected unit's progress towards the next PvP rank.
`rankProgress = GetInspectPVPRankProgress()`

**Returns:**
- `rankProgress`
  - *number* - The progress made toward the next PVP rank normalized between 0 and 1

**Description:**
Requires you to be inspecting a unit and call `GetInspectHonorData()` first before this API returns updated information.
If not inspecting a unit, `NotifyInspect("unit")` must be called first.