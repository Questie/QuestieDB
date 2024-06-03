## Title: C_VoiceChat.EndLocalCapture

**Content:**
Needs summary.
`C_VoiceChat.EndLocalCapture()`

**Description:**
This function is used to end the local voice chat capture. It is typically used in scenarios where you want to stop capturing the user's voice input, such as when the user leaves a voice chat channel or disables voice chat functionality.

**Example Usage:**
```lua
-- Example of ending local voice chat capture
C_VoiceChat.EndLocalCapture()
print("Voice chat capture has been ended.")
```

**Usage in Addons:**
Large addons that manage voice communication, such as "ElvUI" or "DBM (Deadly Boss Mods)", might use this function to control voice chat features, ensuring that voice capture is properly managed when users join or leave voice channels.