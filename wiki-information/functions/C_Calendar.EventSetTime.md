## Title: C_Calendar.EventSetTime

**Content:**
Sets the time for the currently opened event.
`C_Calendar.EventSetTime(hour, minute)`

**Parameters:**
- `hour`
  - *number*
- `minute`
  - *number*

**Description:**
The calendar event must be previously opened with `C_Calendar.OpenEvent` or an event candidate from `C_Calendar.CreatePlayerEvent` and similar.
The calendar event is updated with `C_Calendar.UpdateEvent` or created with `C_Calendar.AddEvent`.