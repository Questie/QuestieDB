## Title: GetNumGuildMembers

**Content:**
Returns the number of total and online guild members.
`numTotalGuildMembers, numOnlineGuildMembers, numOnlineAndMobileMembers = GetNumGuildMembers()`

**Returns:**
- `numTotalGuildMembers`
  - *number* - Total number of players in the Guild, or 0 if not in a guild.
- `numOnlineGuildMembers`
  - *number* - Number of players currently online in Guild, or 0 if not in a guild.
- `numOnlineAndMobileMembers`
  - *number* - Number of players currently online in Guild (includes players online through the mobile application), or 0 if not in a guild.

**Usage:**
```lua
local numTotal, numOnline, numOnlineAndMobile = GetNumGuildMembers();
DEFAULT_CHAT_FRAME:AddMessage(numTotal .. " guild members: " .. numOnline .. " online, " .. (numTotal - numOnline) .. " offline, " .. (numOnlineAndMobile - numOnline) .. " on mobile.");
local numTotal, numOnline, numOnlineAndMobile = GetNumGuildMembers();
DEFAULT_CHAT_FRAME:AddMessage(numTotal .. " guild members: " .. numOnline .. " online, " .. (numTotal - numOnline) .. " offline, " .. (numOnlineAndMobile - numOnline) .. " on mobile.");
```

**Miscellaneous:**
Result:
Displays the number of people online, offline, on mobile, and the total headcount of your guild in the default chat frame.

**Description:**
You may need to call `C_GuildInfo.GuildRoster()` first in order to obtain correct data. May return wrong values immediately after quitting a guild. Maximum returned value is 500.
There is another problem with the return values as they depend on `SetGuildRosterShowOffline()` setting. A simple program like:
```lua
DEFAULT_CHAT_FRAME:AddMessage("Firing SetGuildRosterShowOffline(false)");
SetGuildRosterShowOffline(false)
DEFAULT_CHAT_FRAME:AddMessage("GetNumGuildMembers(): "..tostring(GetNumGuildMembers()));
DEFAULT_CHAT_FRAME:AddMessage("Firing SetGuildRosterShowOffline(true)");
SetGuildRosterShowOffline(true)
DEFAULT_CHAT_FRAME:AddMessage("GetNumGuildMembers(): "..tostring(GetNumGuildMembers()));
```
will show the difference.
Take care, if your function called by `GUILD_ROSTER_UPDATE` event handling wants to set the show offline status via `SetGuildRosterShowOffline()`. This may cause, due to guild roster updates, a loop, where a user that has opened the guild panel can't switch the status anymore, even if you reset the original status in your function.
This is because `SetGuildRosterShowOffline()` fires a `GUILD_ROSTER_UPDATE` event if changed.