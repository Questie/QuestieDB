## Title: C_Calendar.GetEventIndexInfo

**Content:**
Needs summary.
`eventIndexInfo = C_Calendar.GetEventIndexInfo(eventID)`

**Parameters:**
- `eventID`
  - *string*
- `monthOffset`
  - *number?*
- `monthDay`
  - *number?*

**Returns:**
- `eventIndexInfo`
  - *structure* - CalendarEventIndexInfo (nilable)
    - `CalendarEventIndexInfo`
      - `Field`
      - `Type`
      - `Description`
      - `offsetMonths`
        - *number*
      - `monthDay`
        - *number*
      - `eventIndex`
        - *number*