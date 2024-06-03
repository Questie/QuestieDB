## Title: C_Calendar.MassInviteGuild

**Content:**
Needs summary.
`C_Calendar.MassInviteGuild(minLevel, maxLevel, maxRankOrder)`

**Parameters:**
- `minLevel`
  - *number*
- `maxLevel`
  - *number*
- `maxRankOrder`
  - *number*

**Example Usage:**
This function can be used to mass invite guild members to a calendar event based on their level and rank. For instance, if you want to invite all guild members between levels 10 and 50 who are of rank 3 or lower, you would call:
```lua
C_Calendar.MassInviteGuild(10, 50, 3)
```

**Addons:**
Large addons like **Guild Event Manager** might use this function to automate the process of inviting guild members to events, ensuring that only members who meet certain criteria are invited.