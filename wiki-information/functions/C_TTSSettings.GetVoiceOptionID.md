## Title: C_TTSSettings.GetVoiceOptionID

**Content:**
Get the user's preferred text to speech voices.
`voiceID = C_TTSSettings.GetVoiceOptionID(voiceType)`

**Parameters:**
- `voiceType`
  - *Enum.TtsVoiceType*
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - Standard
    - `1`
      - Alternate

**Returns:**
- `voiceID`
  - *number* - Used with `C_VoiceChat.SpeakText()`.