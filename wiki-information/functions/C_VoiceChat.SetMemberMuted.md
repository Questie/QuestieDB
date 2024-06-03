## Title: C_VoiceChat.SetMemberMuted

**Content:**
Needs summary.
`C_VoiceChat.SetMemberMuted(playerLocation, muted)`

**Parameters:**
- `playerLocation`
  - *PlayerLocationMixin* - The location of the player to be muted.
- `muted`
  - *boolean* - Whether the player should be muted (true) or unmuted (false).

**Example Usage:**
```lua
local playerLocation = PlayerLocation:CreateFromUnit("target")
C_VoiceChat.SetMemberMuted(playerLocation, true)
```

This function can be used to programmatically mute or unmute a player in voice chat, which can be useful in addons that manage voice communication, such as raid coordination tools or social addons.