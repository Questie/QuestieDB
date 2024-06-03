## Title: C_VoiceChat.GetMemberInfo

**Content:**
Needs summary.
`memberInfo = C_VoiceChat.GetMemberInfo(memberID, channelID)`

**Parameters:**
- `memberID`
  - *number*
- `channelID`
  - *number*

**Returns:**
- `memberInfo`
  - *structure* - VoiceChatMember (nilable)
    - `VoiceChatMember`
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