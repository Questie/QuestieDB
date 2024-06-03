## Title: C_VoiceChat.SpeakText

**Content:**
Reads text to speech.
`C_VoiceChat.SpeakText(voiceID, text, destination, rate, volume)`

**Parameters:**
- `voiceID`
  - *number* - Voice IDs from `.GetTtsVoices` or `.GetRemoteTtsVoices`.
- `text`
  - *string* - The message to speak.
- `destination`
  - *Enum.VoiceTtsDestination*
    - `Value`
    - `Field`
    - `Description`
    - `0` - RemoteTransmission
    - `1` - LocalPlayback
    - `2` - RemoteTransmissionWithLocalPlayback
    - `3` - QueuedRemoteTransmission
    - `4` - QueuedLocalPlayback
    - `5` - QueuedRemoteTransmissionWithLocalPlayback
    - `6` - ScreenReader
- `rate`
  - *number* - Speech rate; the speed at which the text is read.
- `volume`
  - *number* - Volume level of the speech.

**Description:**
Despite the name, nearly-simultaneous queued messages will play out of order; the 'queue' is neither FIFO or LIFO.
The languages packs installed will vary, and it is possible for none to be installed. The user's local preferences may be found with `C_TTSSettings.GetVoiceOptionID`.

**Usage:**
Speaks a message with Microsoft David (enUS system locale).
```lua
/run C_VoiceChat.SpeakText(0, "Hello world", Enum.VoiceTtsDestination.LocalPlayback, 0, 100)
```
Speaks a message with Microsoft Zira (enUS system locale), with a slower speech rate.
```lua
/run C_VoiceChat.SpeakText(1, "Hello world", Enum.VoiceTtsDestination.LocalPlayback, -10, 100)
```