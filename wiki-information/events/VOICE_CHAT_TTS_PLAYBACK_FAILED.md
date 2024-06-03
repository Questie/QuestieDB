## Event: VOICE_CHAT_TTS_PLAYBACK_FAILED

**Title:** VOICE CHAT TTS PLAYBACK FAILED

**Content:**
Needs summary.
`VOICE_CHAT_TTS_PLAYBACK_FAILED: status, utteranceID, destination`

**Payload:**
- `status`
  - *Enum.VoiceTtsStatusCode*
  - *Value*
  - *Field*
  - *Description*
  - 0
    - Success
  - 1
    - InvalidEngineType
  - 2
    - EngineAllocationFailed
  - 3
    - NotSupported
  - 4
    - MaxCharactersExceeded
  - 5
    - UtteranceBelowMinimumDuration
  - 6
    - InputTextEnqueued
  - 7
    - SdkNotInitialized
  - 8
    - DestinationQueueFull
  - 9
    - EnqueueNotNecessary
  - 10
    - UtteranceNotFound
  - 11
    - ManagerNotFound
  - 12
    - InvalidArgument
  - 13
    - InternalError
- `utteranceID`
  - *number*
- `destination`
  - *Enum.VoiceTtsDestination*
  - *Value*
  - *Field*
  - *Description*
  - 0
    - RemoteTransmission
  - 1
    - LocalPlayback
  - 2
    - RemoteTransmissionWithLocalPlayback
  - 3
    - QueuedRemoteTransmission
  - 4
    - QueuedLocalPlayback
  - 5
    - QueuedRemoteTransmissionWithLocalPlayback
  - 6
    - ScreenReader