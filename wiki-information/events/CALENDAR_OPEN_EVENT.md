## Event: CALENDAR_OPEN_EVENT

**Title:** CALENDAR OPEN EVENT

**Content:**
Fired after calling CalendarOpenEvent once the event data has been retrieved from the server
`CALENDAR_OPEN_EVENT: calendarType`

**Payload:**
- `calendarType`
  - *string* - CALENDARTYPE
    - Value
      - Description
    - "PLAYER"
      - Player-created event or invitation
    - "GUILD_ANNOUNCEMENT"
      - Guild announcement
    - "GUILD_EVENT"
      - Guild event
    - "COMMUNITY_EVENT"
    - "SYSTEM"
      - Other server-provided event
    - "HOLIDAY"
      - Seasonal/holiday events
    - "RAID_LOCKOUT"
      - Instance lockouts