## Title: C_TTSSettings.SetVoiceOptionName

**Content:**
Needs summary.
`C_TTSSettings.SetVoiceOptionName(voiceType, voiceName)`

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
- `voiceName`
  - *string*

**Description:**
This function is used to set the voice option for text-to-speech settings in World of Warcraft. The `voiceType` parameter allows you to choose between standard and alternate voice types, while the `voiceName` parameter specifies the name of the voice to be used.

**Example Usage:**
```lua
-- Set the voice option to the standard voice type with a specific voice name
C_TTSSettings.SetVoiceOptionName(Enum.TtsVoiceType.Standard, "VoiceName1")

-- Set the voice option to the alternate voice type with a different voice name
C_TTSSettings.SetVoiceOptionName(Enum.TtsVoiceType.Alternate, "VoiceName2")
```

**Addons:**
Large addons that provide accessibility features, such as text-to-speech, may use this function to customize the voice settings for users. For example, an addon designed to assist visually impaired players might allow users to select different voices for better clarity and understanding.