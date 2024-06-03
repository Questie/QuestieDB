## Title: C_DateAndTime.CompareCalendarTime

**Content:**
Compares two dates with each other.
`comparison = C_DateAndTime.CompareCalendarTime(lhsCalendarTime, rhsCalendarTime)`

**Parameters:**
- `lhsCalendarTime`
  - *CalendarTime* - left-hand side time
- `rhsCalendarTime`
  - *CalendarTime* - right-hand side time

**CalendarTime Fields:**
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

**Returns:**
- `comparison`
  - *number*
    - `1` : `rhsCalendarTime` is at a later time
    - `0` : `rhsCalendarTime` is at the same time
    - `-1` : `rhsCalendarTime` is at an earlier time