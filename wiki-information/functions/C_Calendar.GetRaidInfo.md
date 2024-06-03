## Title: C_Calendar.GetRaidInfo

**Content:**
Needs summary.
`info = C_Calendar.GetRaidInfo(offsetMonths, monthDay, eventIndex)`

**Parameters:**
- `offsetMonths`
  - *number*
- `monthDay`
  - *number*
- `eventIndex`
  - *number*

**Returns:**
- `info`
  - *structure* - CalendarRaidInfo
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `calendarType`
      - *string*
    - `raidID`
      - *number*
    - `time`
      - *structure* - CalendarTime
    - `difficulty`
      - *number*
    - `difficultyName`
      - *string?*

**CalendarTime:**
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