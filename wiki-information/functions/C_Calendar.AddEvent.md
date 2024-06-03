## Title: C_Calendar.AddEvent

**Content:**
Saves the new event currently being created to the server.
`C_Calendar.AddEvent()`

**Description:**
Finalizes the event candidate created by `C_Calendar.CreatePlayerEvent`, `C_Calendar.CreateGuildSignUpEvent`, and similar.
Requires at least `C_Calendar.EventSetTitle`, `C_Calendar.EventSetDate`, and `C_Calendar.EventSetTime` to be set.
This function is only used to create new events. To save changes to existing events, use `C_Calendar.UpdateEvent`.

**Usage:**
Creates an event for tomorrow.
```lua
C_Calendar.CreatePlayerEvent()
local d = C_DateAndTime.GetCurrentCalendarTime()
C_Calendar.EventSetDate(d.month, d.monthDay+1, d.year)
C_Calendar.EventSetTime(d.hour, d.minute)
C_Calendar.EventSetTitle("hello")
C_Calendar.AddEvent()
```