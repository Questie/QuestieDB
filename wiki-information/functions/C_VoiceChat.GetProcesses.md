## Title: C_VoiceChat.GetProcesses

**Content:**
Needs summary.
`processes = C_VoiceChat.GetProcesses()`

**Returns:**
- `processes`
  - *structure* - VoiceChatProcess
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `channels`
      - *structure* VoiceChatChannel

**VoiceChatChannel:**
- `Field`
- `Type`
- `Description`
- `name`
  - *string*
- `channelID`
  - *number*
- `channelType`
  - *Enum.ChatChannelType*
- `clubId`
  - *string*
- `streamId`
  - *string*
- `volume`
  - *number*
- `isActive`
  - *boolean*
- `isMuted`
  - *boolean*
- `isTransmitting`
  - *boolean*
- `isTranscribing`
  - *boolean*
- `Added in 9.1.0`
- `members`
  - *VoiceChatMember*

**Enum.ChatChannelType:**
- `Value`
- `Field`
- `Description`
- `0`
  - None
- `1`
  - Custom
- `2`
  - Private_Party
  - Documented as "PrivateParty"
- `3`
  - Public_Party
  - Documented as "PublicParty"
- `4`
  - Communities

**VoiceChatMember:**
- `Field`
- `Type`
- `Description`
- `energy`
  - *number*
- `memberID`
  - *number*
- `isActive`
  - *boolean*
- `isSpeaking`
  - *boolean*
- `isMutedForAll`
  - *boolean*
- `isSilenced`
  - *boolean*