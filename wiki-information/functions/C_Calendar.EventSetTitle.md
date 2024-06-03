## Title: C_Calendar.EventSetTitle

**Content:**
Sets the title for the currently opened event.
`C_Calendar.EventSetTitle(title)`

**Parameters:**
- `title`
  - *string*

**Description:**
The calendar event must be previously opened with `C_Calendar.OpenEvent` or an event candidate from `C_Calendar.CreatePlayerEvent` and similar.
The calendar event is updated with `C_Calendar.UpdateEvent` or created with `C_Calendar.AddEvent`.