## Event: VOICE_CHAT_TTS_PLAYBACK_FINISHED

**Title:** VOICE CHAT TTS PLAYBACK FINISHED

**Content:**
Needs summary.
`VOICE_CHAT_TTS_PLAYBACK_FINISHED: numConsumers, utteranceID, destination`

**Payload:**
- `numConsumers`
  - *number*
- `utteranceID`
  - *number*
- `destination`
  - *Enum.VoiceTtsDestination*
  - *Value*
    - *Field* - *Description*
    - 0 - RemoteTransmission
    - 1 - LocalPlayback
    - 2 - RemoteTransmissionWithLocalPlayback
    - 3 - QueuedRemoteTransmission
    - 4 - QueuedLocalPlayback
    - 5 - QueuedRemoteTransmissionWithLocalPlayback
    - 6 - ScreenReader