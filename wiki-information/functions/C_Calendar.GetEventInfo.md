## Title: C_Calendar.GetEventInfo

**Content:**
Returns info for a calendar event.
`info = C_Calendar.GetEventInfo()`

**Returns:**
- `info`
  - *CalendarEventInfo*
    - `Field`
    - `Type`
    - `Description`
    - `title`
      - *string*
    - `description`
      - *string*
    - `creator`
      - *string?* - The name of the character who created the event.
    - `eventType`
      - *Enum.CalendarEventType* - The type of event as specified by `C_Calendar.EventSetType`.
    - `repeatOption`
      - *Enum.CalendarEventRepeatOptions* - The repeat setting.
    - `maxSize`
      - *number* - Usually 100.
    - `textureIndex`
      - *number?* - The index of the event's texture in the list returned by `C_Calendar.EventGetTextures`.
    - `time`
      - *CalendarTime* - When the event occurs.
    - `lockoutTime`
      - *CalendarTime*
    - `isLocked`
      - *boolean* - Whether the event is locked.
    - `isAutoApprove`
      - *boolean* - Whether signups to the event should be automatically approved.
    - `hasPendingInvite`
      - *boolean* - Whether the player has been invited to this event and has not yet responded.
    - `inviteStatus`
      - *Enum.CalendarStatus?* - The character's current invite status for the event.
    - `inviteType`
      - *Enum.CalendarInviteType?*
    - `calendarType`
      - *string* - const `CALENDARTYPE`
    - `communityName`
      - *string?*

**Enum.CalendarEventType**
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

**Enum.CalendarEventRepeatOptions**
- `Value`
- `Field`
- `Description`
  - `0`
    - Never
  - `1`
    - Weekly
  - `2`
    - Biweekly
  - `3`
    - Monthly

**CalendarTime**
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

**Enum.CalendarStatus**
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

**Enum.CalendarInviteType**
- `Value`
- `Field`
- `Description`
  - `0`
    - Normal
  - `1`
    - Signup

**CALENDARTYPE**
- `Value`
- `Description`
  - `"PLAYER"`
    - Player-created event or invitation
  - `"GUILD_ANNOUNCEMENT"`
    - Guild announcement
  - `"GUILD_EVENT"`
    - Guild event
  - `"COMMUNITY_EVENT"`
  - `"SYSTEM"`
    - Other server-provided event
  - `"HOLIDAY"`
    - Seasonal/holiday events
  - `"RAID_LOCKOUT"`
    - Instance lockouts