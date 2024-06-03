## Event: GUILD_INVITE_REQUEST

**Title:** GUILD INVITE REQUEST

**Content:**
Fires when you are invited to join a guild.
`GUILD_INVITE_REQUEST: inviter, guildName, guildAchievementPoints, oldGuildName, isNewGuild, tabardInfo`

**Payload:**
- `inviter`
  - *string*
- `guildName`
  - *string*
- `guildAchievementPoints`
  - *number*
- `oldGuildName`
  - *string*
- `isNewGuild`
  - *boolean?*
- `tabardInfo`
  - *GuildTabardInfo*
  - Field
    - Type
    - Description
  - `backgroundColor`
    - *ColorMixin* 📗
  - `borderColor`
    - *ColorMixin* 📗
  - `emblemColor`
    - *ColorMixin* 📗
  - `emblemFileID`
    - *number*
    - GuildEmblem.db2
  - `emblemStyle`
    - *number*