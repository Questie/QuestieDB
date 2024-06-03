## Title: C_DateAndTime.GetServerTimeLocal

**Content:**
Returns the server's Unix time offset by the server's timezone.
`serverTimeLocal = C_DateAndTime.GetServerTimeLocal()`

**Returns:**
- `serverTimeLocal`
  - *number* - Time in seconds since the epoch, only updates every 60 seconds.

**Miscellaneous:**
When in a EU time zone CEST (UTC+2) and playing on Moon Guard US, CDT (UTC-5). The examples were taken at the same time. Note that `time()` and `date()` are tied to your system's clock which can be manually changed.
```lua
-- unix time
time() -- 1596157547
GetServerTime()) -- 1596157549
-- local time, same as `date(nil, time())`
date() -- "Fri Jul 31 03:05:47 2020"
-- realm time
GetGameTime() -- 20, 4
C_DateAndTime.GetCurrentCalendarTime() -- hour:20, minute:4
C_DateAndTime.GetServerTimeLocal() -- 1596139440 unix time offset by the server's time zone (e.g. UTC minus 5 hours)
```