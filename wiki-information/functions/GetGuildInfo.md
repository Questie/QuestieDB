## Title: GetGuildInfo

**Content:**
Returns guild info for a player unit.
`guildName, guildRankName, guildRankIndex, realm = GetGuildInfo(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId - The unit whose guild information you wish to query.

**Returns:**
- `guildName`
  - *string* - The name of the guild the unit is in (or nil?).
- `guildRankName`
  - *string* - unit's rank in unit's guild.
- `guildRankIndex`
  - *number* - unit's rank (index). - zero based index (0 is Guild Master, 1 and above are lower ranks)
- `realm`
  - *string?* - The name of the realm the guild is in, or nil if the guild's realm is the same as your current one.

**Description:**
This function only works in close proximity to the unit you are trying to get info from. It is the same distance that the character portrait loads if you are in party with them. It will abandon the data shortly after you leave the area, even if the portrait is remembered.

If using with UnitId "player" on loading it happens that this value is nil even if the player is in a guild. Here's a little function which checks in the `GUILD_ROSTER_UPDATE` and `PLAYER_GUILD_UPDATE` events, if guild name is available. As long as it is not, no actions are fired by my guild event handling.

```lua
local function IsPlayerInGuild()
  return IsInGuild() and GetGuildInfo("player")
end
```

**Example Usage:**
This function can be used to display guild information for a player in a custom UI element or addon. For instance, you might use it to show the guild name and rank of party members in a custom party frame.

**Addon Usage:**
Many large addons, such as ElvUI and PitBull Unit Frames, use `GetGuildInfo` to display guild information in their unit frames. This allows players to see at a glance which guild their party or raid members belong to and their rank within that guild.