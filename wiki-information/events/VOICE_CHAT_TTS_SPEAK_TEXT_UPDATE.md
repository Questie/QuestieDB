## Event: VOICE_CHAT_TTS_SPEAK_TEXT_UPDATE

**Title:** VOICE CHAT TTS SPEAK TEXT UPDATE

**Content:**
Needs summary.
`VOICE_CHAT_TTS_SPEAK_TEXT_UPDATE: status, utteranceID`

**Payload:**
- `status`
  - *Enum.VoiceTtsStatusCode*
  - *Value*
  - *Field*
  - *Description*
  - 0 - Success
  - 1 - InvalidEngineType
  - 2 - EngineAllocationFailed
  - 3 - NotSupported
  - 4 - MaxCharactersExceeded
  - 5 - UtteranceBelowMinimumDuration
  - 6 - InputTextEnqueued
  - 7 - SdkNotInitialized
  - 8 - DestinationQueueFull
  - 9 - EnqueueNotNecessary
  - 10 - UtteranceNotFound
  - 11 - ManagerNotFound
  - 12 - InvalidArgument
  - 13 - InternalError
- `utteranceID`
  - *number*