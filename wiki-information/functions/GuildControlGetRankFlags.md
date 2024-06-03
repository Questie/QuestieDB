## Title: GuildControlGetRankFlags

**Content:**
Returns information about the currently selected guild rank.
```lua
guildchat_listen, guildchat_speak, officerchat_listen, officerchat_speak, promote, demote, invite_member, remove_member, set_motd, edit_public_note, view_officer_note, edit_officer_note, modify_guild_info, _, withdraw_repair, withdraw_gold, create_guild_event, authenticator, modify_bank_tabs, remove_guild_event = GuildControlGetRankFlags()
```

**Returns:**
If no rank has been selected via `GuildControlSetRank`, the function will return false for all flags.
- `guildchat_listen`
  - *Boolean* - true if players of the rank can listen to guild chat.
- `guildchat_speak`
  - *Boolean* - true if players of the rank can speak in guild chat.
- `officerchat_listen`
  - *Boolean* - true if players of the rank can listen to officer chat.
- `officerchat_speak`
  - *Boolean* - true if players of the rank can speak in officer chat.
- `promote`
  - *Boolean* - true if players of the rank promote lower ranked players.
- `demote`
  - *Boolean* - true if players of the rank demote lower ranked players.
- `invite_member`
  - *Boolean* - true if players of the rank invite new players to the guild.
- `remove_member`
  - *Boolean* - true if players of the rank remove players from the guild.
- `set_motd`
  - *Boolean* - true if players of the rank can edit guild message of the day.
- `edit_public_note`
  - *Boolean* - true if players of the rank can edit public notes.
- `view_officer_note`
  - *Boolean* - true if players of the rank can view officer notes.
- `edit_officer_note`
  - *Boolean* - true if players of the rank can edit officer notes.
- `modify_guild_info`
  - *Boolean* - true if players of the rank modify guild information.
- `withdraw_repair`
  - *Boolean* - true if players of the rank are allowed to repair using guild bank.
- `withdraw_gold`
  - *Boolean* - true if players of the rank are allowed to withdraw gold from the guild bank.
- `create_guild_event`
  - *Boolean* - true if players of the rank can create guild events on the calendar.
- `authenticator`
  - *Boolean* - true if players must have an authenticator attached to the account to be promoted to this rank.
- `modify_bank_tabs`
  - *Boolean* - true if players of the rank can change bank tab labels.
- `remove_guild_event`
  - *Boolean* - true if players of the rank can remove guild events on the calendar.

**Usage:**
```lua
local _, _, playerrank = GetGuildInfo("player")
GuildControlSetRank(playerrank + 1)
local guildchat_listen, guildchat_speak, officerchat_listen, officerchat_speak, ... = GuildControlGetRankFlags()
```

**Notes and Caveats:**
- The 14th return value is obsolete and should be ignored.
- "modify_bank_tabs" and "remove_guild_event" were added in Patch 4.1. Another flag, "recruitment", exists as label text for the next flag in line, but is not yet returned by this function.