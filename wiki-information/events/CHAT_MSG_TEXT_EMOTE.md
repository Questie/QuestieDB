## Event: CHAT_MSG_TEXT_EMOTE

**Title:** CHAT MSG TEXT EMOTE

**Content:**
Fired for emotes with an emote token. /dance, /healme, etc.
`CHAT_MSG_TEXT_EMOTE: text, playerName, languageName, channelName, playerName2, specialFlags, zoneChannelID, channelIndex, channelBaseName, languageID, lineID, guid, bnSenderID, isMobile, isSubtitle, hideSenderInLetterbox, supressRaidIcons`

**Payload:**
- `text`
  - *string* - e.g. "You threaten Rabbit with the wrath of doom."
- `playerName`
  - *string* - Name of the person who emoted.
- `languageName`
  - *string* - Localized name of the language if applicable, e.g. "Common" or "Thalassian"
- `channelName`
  - *string* - Channel name with channelIndex, e.g. "2. Trade - City"
- `playerName2`
  - *string* - The target name when there are two users involved, otherwise the same as playerName or an empty string.
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