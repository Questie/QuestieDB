## Event: VOICE_CHAT_CHANNEL_JOINED

**Title:** VOICE CHAT CHANNEL JOINED

**Content:**
Needs summary.
`VOICE_CHAT_CHANNEL_JOINED: status, channelID, channelType, clubId, streamId`

**Payload:**
- `status`
  - *number* - Enum.VoiceChatStatusCode
- `channelID`
  - *number*
- `channelType`
  - *number* - Enum.ChatChannelType
- `clubId`
  - *string?*
- `streamId`
  - *string?*
- Enum.VoiceChatStatusCode
  - Value
  - Field
  - Description
  - 0
    - Success
  - 1
    - OperationPending
  - 2
    - TooManyRequests
  - 3
    - LoginProhibited
  - 4
    - ClientNotInitialized
  - 5
    - ClientNotLoggedIn
  - 6
    - ClientAlreadyLoggedIn
  - 7
    - ChannelNameTooShort
  - 8
    - ChannelNameTooLong
  - 9
    - ChannelAlreadyExists
  - 10
    - AlreadyInChannel
  - 11
    - TargetNotFound
  - 12
    - Failure
  - 13
    - ServiceLost
  - 14
    - UnableToLaunchProxy
  - 15
    - ProxyConnectionTimeOut
  - 16
    - ProxyConnectionUnableToConnect
  - 17
    - ProxyConnectionUnexpectedDisconnect
  - 18
    - Disabled
  - 19
    - UnsupportedChatChannelType
  - 20
    - InvalidCommunityStream
  - 21
    - PlayerSilenced
  - 22
    - PlayerVoiceChatParentalDisabled
  - 23
    - InvalidInputDevice
    - Added in 8.2.0
  - 24
    - InvalidOutputDevice
    - Added in 8.2.0
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