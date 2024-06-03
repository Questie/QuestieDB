## Title: C_Calendar.OpenCalendar

**Content:**
Requests calendar information from the server. Does not open the calendar frame.
`C_Calendar.OpenCalendar()`

**Description:**
Fires `CALENDAR_UPDATE_EVENT_LIST` when your query has finished processing on the server and new calendar information is available.
If called during the loading process, (even at `PLAYER_ENTERING_WORLD`) the query will not return.