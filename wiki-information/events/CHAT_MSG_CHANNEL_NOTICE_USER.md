## Event: CHAT_MSG_CHANNEL_NOTICE_USER

**Title:** CHAT MSG CHANNEL NOTICE USER

**Content:**
Fired when something changes in the channel like moderation enabled, user is kicked, announcements changed and so on. CHAT_*_NOTICE in GlobalStrings.lua has a full list of available types.
`CHAT_MSG_CHANNEL_NOTICE_USER: text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons`

**Payload:**
- `text`
  - *string* - "ANNOUNCEMENTS_OFF", "ANNOUNCEMENTS_ON", "BANNED", "OWNER_CHANGED", "INVALID_NAME", "INVITE", "MODERATION_OFF", "MODERATION_ON", "MUTED", "NOT_MEMBER", "NOT_MODERATED", "SET_MODERATOR", "UNSET_MODERATOR"
- `playerName`
  - *string* - If arg5 has a value then this is the user affected (e.g. "Player Foo has been kicked by Bar"), if arg5 has no value then it's the person who caused the event (e.g. "Channel Moderation has been enabled by Bar")
- `languageName`
  - *string* - Localized name of the language if applicable, e.g. "Common" or "Thalassian"
- `channelName`
  - *string* - Channel name with channelIndex, e.g. "2. Trade - City"
- `playerName2`
  - *string* - Player that caused the event (e.g. "Player Foo has been kicked by Bar")
- `specialFlags`
  - *string* - User flags if applicable, possible values are: "GM", "DEV", "AFK", "DND", "COM"
- `zoneChannelID`
  - *number* - The static ID of the zone channel, e.g. 1 for General, 2 for Trade and 22 for LocalDefense.
- `channelIndex`
  - *number* - Channel index, this usually is related to the order in which you joined each channel.
- `channelBaseName`
  - *string* - Channel name without the number, e.g. "Trade - City"
- `languageID`
  - *number* - LanguageID
- `lineID`
  - *number* - Unique chat lineID for differentiating/reporting chat messages. Can be passed to `PlayerLocation:CreateFromChatLineID()`
- `guid`
  - *string* - Sender's Unit GUID.
- `bnSenderID`
  - *number* - ID of the Battle.net friend.
- `isMobile`
  - *boolean* - If the sender is using the Blizzard Battle.net Mobile app.
- `isSubtitle`
  - *boolean*
- `hideSenderInLetterbox`
  - *boolean* - Whether this chat message is meant to show in the CinematicFrame only.
- `supressRaidIcons`
  - *boolean* - Whether Target marker expressions like {rt7} and {diamond} should not be rendered with `C_ChatInfo.ReplaceIconAndGroupExpressions()`