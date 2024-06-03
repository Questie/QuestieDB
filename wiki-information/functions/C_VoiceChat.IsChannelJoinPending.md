## Title: C_VoiceChat.IsChannelJoinPending

**Content:**
Needs summary.
`isPending = C_VoiceChat.IsChannelJoinPending(channelType)`

**Parameters:**
- `channelType`
  - *Enum.ChatChannelType*
- `clubId`
  - *string?*
- `streamId`
  - *string?*

**Enum.ChatChannelType Values:**
- `0`
  - `None`
- `1`
  - `Custom`
- `2`
  - `Private_Party`
    - Documented as "PrivateParty"
- `3`
  - `Public_Party`
    - Documented as "PublicParty"
- `4`
  - `Communities`

**Returns:**
- `isPending`
  - *boolean*