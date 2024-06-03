## Title: C_Calendar.EventGetInvite

**Content:**
Returns status information for an invitee for the currently opened event.
`info = C_Calendar.EventGetInvite(eventIndex)`

**Parameters:**
- `eventIndex`
  - *number* - Ranging from 1 to `C_Calendar.GetNumInvites()`

**Returns:**
- `info`
  - *CalendarEventInviteInfo*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string?*
    - `level`
      - *number*
    - `className`
      - *string?*
    - `classFilename`
      - *string?*
    - `inviteStatus`
      - *Enum.CalendarStatus?*
    - `modStatus`
      - *string?* - "MODERATOR", "CREATOR"
    - `inviteIsMine`
      - *boolean* - True if the selected entry is the player
    - `type`
      - *Enum.CalendarInviteType*
    - `notes`
      - *string*
    - `classID`
      - *number?*
    - `guid`
      - *string*

**Enum.CalendarStatus:**
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

**Enum.CalendarInviteType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Normal
  - `1`
    - Signup