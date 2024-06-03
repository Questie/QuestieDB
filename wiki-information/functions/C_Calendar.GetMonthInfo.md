## Title: C_Calendar.GetMonthInfo

**Content:**
Returns information about the calendar month by offset.
`monthInfo = C_Calendar.GetMonthInfo()`

**Parameters:**
- `offsetMonths`
  - *number? = 0* - Offset in months from the currently selected Calendar month, positive numbers indicating future months.

**Returns:**
- `monthInfo`
  - *structure* - CalendarMonthInfo
    - `Field`
    - `Type`
    - `Description`
    - `month`
      - *number* - Month index (1-12)
    - `year`
      - *number* - Year at the offset date (2004+)
    - `numDays`
      - *number* - Number of days in the month (28-31)
    - `firstWeekday`
      - *number* - Weekday on which the month begins (1 = Sunday, 2 = Monday, ..., 7 = Saturday)

**Description:**
This function returns information based on the currently selected calendar month (per `C_Calendar.SetMonth`). Prior to opening the calendar for the first time in a given session, this is set to `C_Calendar.GetMinDate` (i.e. November 2004).