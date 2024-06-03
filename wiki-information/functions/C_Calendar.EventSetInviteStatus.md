## Title: C_Calendar.EventSetInviteStatus

**Content:**
Sets the invitation status of a player to the current event.
`C_Calendar.EventSetInviteStatus(eventIndex, status)`

**Parameters:**
- `eventIndex`
  - *number*
- `status`
  - *Enum.CalendarStatus*
    - `Value`
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