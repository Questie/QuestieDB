## Title: C_VoiceChat.Login

**Content:**
Needs summary.
`status = C_VoiceChat.Login()`

**Returns:**
- `status`
  - *Enum.VoiceChatStatusCode*
    - `Enum.VoiceChatStatusCode`
      - `Value`
      - `Field`
      - `Description`
        - `0` - Success
        - `1` - OperationPending
        - `2` - TooManyRequests
        - `3` - LoginProhibited
        - `4` - ClientNotInitialized
        - `5` - ClientNotLoggedIn
        - `6` - ClientAlreadyLoggedIn
        - `7` - ChannelNameTooShort
        - `8` - ChannelNameTooLong
        - `9` - ChannelAlreadyExists
        - `10` - AlreadyInChannel
        - `11` - TargetNotFound
        - `12` - Failure
        - `13` - ServiceLost
        - `14` - UnableToLaunchProxy
        - `15` - ProxyConnectionTimeOut
        - `16` - ProxyConnectionUnableToConnect
        - `17` - ProxyConnectionUnexpectedDisconnect
        - `18` - Disabled
        - `19` - UnsupportedChatChannelType
        - `20` - InvalidCommunityStream
        - `21` - PlayerSilenced
        - `22` - PlayerVoiceChatParentalDisabled
        - `23` - InvalidInputDevice (Added in 8.2.0)
        - `24` - InvalidOutputDevice (Added in 8.2.0)