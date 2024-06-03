## Title: C_Calendar.GetGuildEventInfo

**Content:**
Needs summary.
`info = C_Calendar.GetGuildEventInfo(index)`

**Parameters:**
- `index`
  - *number*

**Returns:**
- `info`
  - *CalendarGuildEventInfo*
    - `Field`
    - `Type`
    - `Description`
    - `eventID`
      - *string*
    - `year`
      - *number*
    - `month`
      - *number*
    - `monthDay`
      - *number*
    - `weekday`
      - *number*
    - `hour`
      - *number*
    - `minute`
      - *number*
    - `eventType`
      - *Enum.CalendarEventType*
    - `title`
      - *string*
    - `calendarType`
      - *string*
    - `texture`
      - *number*
    - `inviteStatus`
      - *number*
    - `clubID`
      - *string*

**Enum.CalendarEventType:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Raid
  - `1`
    - Dungeon
  - `2`
    - PvP
  - `3`
    - Meeting
  - `4`
    - Other
  - `5`
    - HeroicDeprecated