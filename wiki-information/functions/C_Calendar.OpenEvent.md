## Title: C_Calendar.OpenEvent

**Content:**
Establishes an event for future calendar API calls
`success = C_Calendar.OpenEvent(offsetMonths, monthDay, index)`

**Parameters:**
- `offsetMonths`
  - *number* - The number of months to offset from today.
- `monthDay`
  - *number* - The day of the month on which the desired event is scheduled (1 - 31).
- `index`
  - *number* - Ranging from 1 through `C_Calendar.GetNumDayEvents(offsetMonths, monthDay)`.

**Returns:**
- `success`
  - *boolean*