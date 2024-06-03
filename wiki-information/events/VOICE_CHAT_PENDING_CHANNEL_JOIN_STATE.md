## Event: VOICE_CHAT_PENDING_CHANNEL_JOIN_STATE

**Title:** VOICE CHAT PENDING CHANNEL JOIN STATE

**Content:**
Needs summary.
`VOICE_CHAT_PENDING_CHANNEL_JOIN_STATE: channelType, clubId, streamId, pendingJoin`

**Payload:**
- `channelType`
  - *number* - Enum.ChatChannelType
- `clubId`
  - *string?*
- `streamId`
  - *string?*
- `pendingJoin`
  - *boolean*
- Enum.ChatChannelType
  - Value
  - Field
  - Description
  - 0
  - None
  - 1
  - Custom
  - 2
  - Private_Party
  - Documented as "PrivateParty"
  - 3
  - Public_Party
  - Documented as "PublicParty"
  - 4
  - Communities