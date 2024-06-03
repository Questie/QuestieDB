## Title: C_ReportSystem.SetPendingReportTarget

**Content:**
Populates the reporting window with details about a target player.
`set = C_ReportSystem.SetPendingReportTarget()`
`set = C_ReportSystem.SetPendingReportTargetByGuid()`

**Parameters:**

*SetPendingReportTarget:*
- `target`
  - *string?* : UnitId - defaults to "target"

*SetPendingReportTargetByGuid:*
- `guid`
  - *string?* : GUID

**Returns:**
- `set`
  - *boolean* - whether the report was successfully set.