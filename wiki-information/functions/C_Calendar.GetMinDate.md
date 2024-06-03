## Title: C_Calendar.GetMinDate

**Content:**
Returns the first day supported by the Calendar API.
`minDate = C_Calendar.GetMinDate()`

**Returns:**
- `minDate`
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
As of Patch 8.1.5, the date returned by this function on EU realms is Wednesday the 24th of November, 2004.