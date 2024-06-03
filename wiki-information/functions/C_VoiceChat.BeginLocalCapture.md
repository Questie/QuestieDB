## Title: C_VoiceChat.BeginLocalCapture

**Content:**
Needs summary.
`C_VoiceChat.BeginLocalCapture(listenToLocalUser)`

**Parameters:**
- `listenToLocalUser`
  - *boolean*

**Description:**
This function is used to start capturing local voice input. The `listenToLocalUser` parameter determines whether the local user can hear their own voice during the capture.

**Example Usage:**
```lua
-- Start capturing local voice input and allow the user to hear their own voice
C_VoiceChat.BeginLocalCapture(true)
```

**Use in Addons:**
Large addons like **DBM (Deadly Boss Mods)** and **ElvUI** might use this function to provide voice communication features within their interfaces, allowing users to communicate more effectively during gameplay.