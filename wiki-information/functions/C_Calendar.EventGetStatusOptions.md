## Title: C_Calendar.EventGetStatusOptions

**Content:**
Needs summary.
`options = C_Calendar.EventGetStatusOptions(eventIndex)`

**Parameters:**
- `eventIndex`
  - *number*

**Returns:**
- `options`
  - *CalendarEventStatusOption*
    - `Field`
    - `Type`
    - `Description`
    - `status`
      - *Enum.CalendarStatus*
    - `statusString`
      - *string*
    - `Enum.CalendarStatus`
      - *Value*
        - `Field`
        - `Description`
        - `0`
          - Invited
        - `1`
          - Available
        - `2`
          - Declined
        - `3`
          - Confirmed
        - `4`
          - Out
        - `5`
          - Standby
        - `6`
          - Signedup
        - `7`
          - NotSignedup
        - `8`
          - Tentative