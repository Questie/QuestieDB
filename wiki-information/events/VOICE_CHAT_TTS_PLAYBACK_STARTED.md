## Event: VOICE_CHAT_TTS_PLAYBACK_STARTED

**Title:** VOICE CHAT TTS PLAYBACK STARTED

**Content:**
Needs summary.
`VOICE_CHAT_TTS_PLAYBACK_STARTED: numConsumers, utteranceID, durationMS, destination`

**Payload:**
- `numConsumers`
  - *number*
- `utteranceID`
  - *number*
- `durationMS`
  - *number*
- `destination`
  - *Enum.VoiceTtsDestination*
  - *Value*
    - *Field* - Description
    - 0 - RemoteTransmission
    - 1 - LocalPlayback
    - 2 - RemoteTransmissionWithLocalPlayback
    - 3 - QueuedRemoteTransmission
    - 4 - QueuedLocalPlayback
    - 5 - QueuedRemoteTransmissionWithLocalPlayback
    - 6 - ScreenReader