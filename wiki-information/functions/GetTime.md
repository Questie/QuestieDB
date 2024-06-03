## Title: GetTime

**Content:**
Returns the system uptime of your computer in seconds, with millisecond precision.
`seconds = GetTime()`

**Returns:**
- `seconds`
  - *number* - The current system uptime in seconds, e.g. 60123.558

**Description:**
This value is only updated once per rendered frame. Finer-grained timers are available using `GetTimePreciseSec()` or `debugprofilestop()`.
It is possible for this function to return identical values across consecutive frames if a low-resolution timing method is in use while running at a high framerate.

**Reference:**
- `time()`, `date()`
- `GetGameTime()`
- `GetTimePreciseSec()`
- `CVar timingMethod`