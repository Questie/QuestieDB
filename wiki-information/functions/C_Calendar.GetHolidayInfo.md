## Title: C_Calendar.GetHolidayInfo

**Content:**
Returns seasonal holiday info.
`event = C_Calendar.GetHolidayInfo(monthOffset, monthDay, index)`

**Parameters:**
- `monthOffset`
  - *number* - The offset from the current month (only accepts 0 or 1).
- `monthDay`
  - *number* - The day of the month.
- `index`
  - *number*

**Returns:**
- `event`
  - *CalendarHolidayInfo*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `description`
      - *string*
    - `texture`
      - *number*
    - `startTime`
      - *CalendarTime?*
    - `endTime`
      - *CalendarTime?*
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