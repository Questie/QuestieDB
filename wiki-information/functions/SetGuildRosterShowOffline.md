## Title: SetGuildRosterShowOffline

**Content:**
Sets the show offline guild members flag.
`SetGuildRosterShowOffline(enabled)`

**Parameters:**
- `enabled`
  - *boolean* - True includes all guild members; false filters out offline guild members.

**Description:**
Triggers `GUILD_ROSTER_UPDATE` if filtering mode has changed -- facilitating a customary call to `GuildRoster()` if this event is registered.

**Usage:**
```lua
-- Fetch updated info when required
local f = CreateFrame("Frame")
f:RegisterEvent("GUILD_ROSTER_UPDATE")
f:HookScript("OnEvent", function(event)
    if (event == "GUILD_ROSTER_UPDATE") then
        GuildRoster()
    end
end)

-- At some point later in your code...
SetGuildRosterShowOffline(false)
```

**Example Use Case:**
This function can be used in an addon to manage the display of guild members, ensuring that only online members are shown in the guild roster. This can be particularly useful for guild management addons that need to provide a clean and relevant list of active members.

**Addons Using This Function:**
Large guild management addons like "Guild Roster Manager" use this function to toggle the visibility of offline members, providing a more streamlined interface for guild officers and members.