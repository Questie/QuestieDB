## Title: C_Calendar.GetClubCalendarEvents

**Content:**
Needs summary.
`events = C_Calendar.GetClubCalendarEvents(clubId, startTime, endTime)`

**Parameters:**
- `clubId`
  - *string*
- `startTime`
  - *CalendarTime*
- `endTime`
  - *CalendarTime*

**CalendarTime Fields:**
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

**Returns:**
- `events`
  - *CalendarDayEvent*

**CalendarDayEvent Fields:**
- `eventID`
  - *string* - Added in 8.1.0
- `title`
  - *string*
- `isCustomTitle`
  - *boolean* - Added in 8.0.1
- `startTime`
  - *CalendarTime*
- `endTime`
  - *CalendarTime*
- `calendarType`
  - *string* - const CALENDARTYPE
- `sequenceType`
  - *string* - "START", "END", "", "ONGOING"
- `eventType`
  - *Enum.CalendarEventType*
- `iconTexture`
  - *number?* - Added in 7.2.5
- `modStatus`
  - *string* - "MODERATOR", "CREATOR"
- `inviteStatus`
  - *Enum.CalendarStatus*
- `invitedBy`
  - *string*
- `difficulty`
  - *number*
- `inviteType`
  - *Enum.CalendarInviteType*
- `sequenceIndex`
  - *number*
- `numSequenceDays`
  - *number*
- `difficultyName`
  - *string*
- `dontDisplayBanner`
  - *boolean*
- `dontDisplayEnd`
  - *boolean*
- `clubID`
  - *string* - Added in 8.1.5
- `isLocked`
  - *boolean* - Added in 8.2.0

**CALENDARTYPE Values:**
- `"PLAYER"` - Player-created event or invitation
- `"GUILD_ANNOUNCEMENT"` - Guild announcement
- `"GUILD_EVENT"` - Guild event
- `"COMMUNITY_EVENT"`
- `"SYSTEM"` - Other server-provided event
- `"HOLIDAY"` - Seasonal/holiday events
- `"RAID_LOCKOUT"` - Instance lockouts

**Enum.CalendarEventType Values:**
- `0` - Raid
- `1` - Dungeon
- `2` - PvP
- `3` - Meeting
- `4` - Other
- `5` - HeroicDeprecated

**Enum.CalendarStatus Values:**
- `0` - Invited
- `1` - Available
- `2` - Declined
- `3` - Confirmed
- `4` - Out
- `5` - Standby
- `6` - Signedup
- `7` - NotSignedup
- `8` - Tentative

**Enum.CalendarInviteType Values:**
- `0` - Normal
- `1` - Signup