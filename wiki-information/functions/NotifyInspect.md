## Title: NotifyInspect

**Content:**
Requests another player's inventory and talent info before inspecting.
`NotifyInspect(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit to inspect.

**Description:**
Triggers `INSPECT_READY` when information is asynchronously available.
Requires an eligible unit within range, confirmed with `CanInspect()` and `CheckInteractDistance()`.
The client continues checking equipment and talent changes until halted by `ClearInspectPlayer()`.

**Reference:**
- `RequestInspectHonorData()` - Classic only function for PvP statistics.