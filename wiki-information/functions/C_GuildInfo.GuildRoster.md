## Title: C_GuildInfo.GuildRoster

**Content:**
Requests updated guild roster information from the server.
`C_GuildInfo.GuildRoster()`

**Description:**
`GUILD_ROSTER_UPDATE` fires when updated (but not necessarily altered) information is received from the server.
The call will be ignored completely if the last `GuildRoster()` call was less than 10 seconds ago (most likely to limit the traffic caused by frequent opening/closing of the guild tab).

**Reference:**
`GetGuildRosterInfo`