## Title: C_Calendar.EventSetDate

**Content:**
Sets the date for the currently opened event.
`C_Calendar.EventSetDate(month, monthDay, year)`

**Parameters:**
- `month`
  - *number* - 2 digits.
- `monthDay`
  - *number* - 2 digits.
- `year`
  - *number* - 4 digits (e.g., 2019).

**Description:**
The calendar event must be previously opened with `C_Calendar.OpenEvent` or an event candidate from `C_Calendar.CreatePlayerEvent` and similar.
The calendar event is updated with `C_Calendar.UpdateEvent` or created with `C_Calendar.AddEvent`.