## Title: C_VoiceChat.RequestJoinChannelByChannelType

**Content:**
Needs summary.
`C_VoiceChat.RequestJoinChannelByChannelType(channelType)`

**Parameters:**
- `channelType`
  - *Enum.ChatChannelType*
    - `Value`
    - `Field`
    - `Description`
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

**Additional Information:**
- `autoActivate`
  - *boolean?*

**Example Usage:**
```lua
-- Example of joining a custom voice chat channel
C_VoiceChat.RequestJoinChannelByChannelType(Enum.ChatChannelType.Custom)
```

**Addons Usage:**
Large addons like **DBM (Deadly Boss Mods)** and **ElvUI** might use this function to facilitate voice communication within custom or party channels, enhancing coordination during raids or group activities.