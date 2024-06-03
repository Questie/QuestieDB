## Title: C_DateAndTime.AdjustTimeByDays

**Content:**
Returns the date after a specified amount of days.
`newDate = C_DateAndTime.AdjustTimeByDays(date, days)`
`newDate = C_DateAndTime.AdjustTimeByMinutes(date, minutes)`

**Parameters:**
- **AdjustTimeByDays:**
  - `date`
    - *CalendarTime*
  - `days`
    - *number*
- **AdjustTimeByMinutes:**
  - `date`
    - *CalendarTime*
  - `minutes`
    - *number*

**Returns:**
- `newDate`
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