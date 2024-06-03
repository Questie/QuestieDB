## Title: IsInGuild

**Content:**
Lets you know whether you are in a guild.
`inGuild = IsInGuild()`

**Returns:**
- `inGuild`
  - *boolean*

**Usage:**
```lua
if IsInGuild() then
  SendChatMessage("Hi Guild!", "GUILD")
end
```

**Example Use Case:**
This function can be used to check if the player is currently in a guild before performing guild-specific actions, such as sending a message to the guild chat.

**Addons Using This Function:**
Many addons that provide guild management features or enhance guild communication, such as "Guild Roster Manager" or "GreenWall," use this function to ensure that the player is in a guild before executing guild-related functionalities.