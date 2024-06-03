## Event: CHAT_MSG_ADDON

**Title:** CHAT MSG ADDON

**Content:**
Fires when the client receives an addon message.
`CHAT_MSG_ADDON: prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID`

**Payload:**
- `prefix`
  - *string* - The registered prefix as used in `C_ChatInfo.RegisterAddonMessagePrefix()`
- `text`
  - *string* - The message body
- `channel`
  - *string* - The addon channel's chat type, e.g. "PARTY"
- `sender`
  - *string* - Player who initiated the message
- `target`
  - *string* - The channel index and name, e.g. "4. test"; or for the "WHISPER" chat type, same as sender
- `zoneChannelID`
  - *number* - Seems to be always 0
- `localID`
  - *number* - The channel index or 0 if not applicable.
- `name`
  - *string* - The channel name or an empty string if not applicable.
- `instanceID`
  - *number* - Seems to be always 0

**Content Details:**
Related API
C_ChatInfo.SendAddonMessage
Related Events
CHAT_MSG_ADDON_LOGGED