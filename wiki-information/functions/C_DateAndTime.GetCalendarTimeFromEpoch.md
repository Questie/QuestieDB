## Title: C_DateAndTime.GetCalendarTimeFromEpoch

**Content:**
Returns the date for a specified amount of time since the UNIX epoch for the OS time zone.
`date = C_DateAndTime.GetCalendarTimeFromEpoch(epoch)`

**Parameters:**
- `epoch`
  - *number* - time in microseconds

**Returns:**
- `date`
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
local d = C_DateAndTime.GetCalendarTimeFromEpoch(1e6 * 60 * 60 * 24)
print(format("One day since epoch is %d-%02d-%02d %02d:%02d", d.year, d.month, d.monthDay, d.hour, d.minute))
-- Output: One day since epoch is 1970-01-02 01:00
```