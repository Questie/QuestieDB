## Title: C_Calendar.EventGetInviteResponseTime

**Content:**
Needs summary.
`time = C_Calendar.EventGetInviteResponseTime(eventIndex)`

**Parameters:**
- `eventIndex`
  - *number*

**Returns:**
- `time`
  - *Structure* - CalendarTime
    - `CalendarTime`
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