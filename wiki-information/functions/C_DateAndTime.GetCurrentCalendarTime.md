## Title: C_DateAndTime.GetCurrentCalendarTime

**Content:**
Returns the realm's current date and time.
`currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime()`

**Returns:**
- `currentCalendarTime`
  - *CalendarTime*
    - `Field`
    - `Type`
    - `Description`
    - `year`
      - *number* - The current year (e.g. 2019)
    - `month`
      - *number* - The current month
    - `monthDay`
      - *number* - The current day of the month
    - `weekday`
      - *number* - The current day of the week (1=Sunday, 2=Monday, ..., 7=Saturday)
    - `hour`
      - *number* - The current time in hours
    - `minute`
      - *number* - The current time in minutes

**Usage:**
```lua
local d = C_DateAndTime.GetCurrentCalendarTime()
local weekDay = CALENDAR_WEEKDAY_NAMES
local month = CALENDAR_FULLDATE_MONTH_NAMES
print(format("The time is %02d:%02d, %s, %d %s %d", d.hour, d.minute, weekDay, d.monthDay, month, d.year))
-- The time is 07:55, Friday, 15 March 2019
```

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