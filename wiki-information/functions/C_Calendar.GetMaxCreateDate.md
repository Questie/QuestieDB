## Title: C_Calendar.GetMaxCreateDate

**Content:**
Returns the last day supported by the Calendar API.
`maxCreateDate = C_Calendar.GetMaxCreateDate()`

**Returns:**
- `maxCreateDate`
  - *structure* - CalendarTime
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

**Description:**
As of the 21st of March 2019, the date returned by this function on EU realms is Tuesday the 31st of March, 2020.