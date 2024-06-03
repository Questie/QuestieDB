## Title: GetServerTime

**Content:**
Returns the server's Unix time.
`timestamp = GetServerTime()`

**Returns:**
- `timestamp`
  - *number* - Time in seconds since the epoch.

**Description:**
The server's Unix timestamp is more preferable over `time()` since it's guaranteed to be synchronized between clients. The local machine's clock could possibly have been manually changed and might also be off by a few seconds if not recently synced.
Adjustments to the local system clock while the client is open may result in this function returning incorrect timestamps.
Unix time is unrelated to your time zone, making it useful for tracking and sorting timestamps.

**Miscellaneous:**
When in a EU time zone CEST (UTC+2) and playing on Moon Guard US, CDT (UTC-5). The examples were taken at the same time. Note that `time()` and `date()` are tied to your system's clock which can be manually changed.
```lua
-- unix time
time() -- 1596157547
GetServerTime() -- 1596157549
-- local time, same as `date(nil, time())`
date() -- "Fri Jul 31 03:05:47 2020"
-- realm time
GetGameTime() -- 20, 4
C_DateAndTime.GetCurrentCalendarTime() -- hour:20, minute:4
C_DateAndTime.GetServerTimeLocal() -- 1596139440 unix time offset by the server's time zone (e.g. UTC minus 5 hours)
```

**Reference:**
- `GetTime()` - local machine uptime.