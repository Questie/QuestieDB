## Title: C_TTSSettings.GetChannelEnabled

**Content:**
Needs summary.
`enabled = C_TTSSettings.GetChannelEnabled(channelInfo)`

**Parameters:**
- `channelInfo`
  - *ChatChannelInfo*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `shortcut`
      - *string*
    - `localID`
      - *number*
    - `instanceID`
      - *number*
    - `zoneChannelID`
      - *number*
    - `channelType`
      - *Enum.PermanentChatChannelType*
        - `Enum.PermanentChatChannelType`
          - `Value`
          - `Field`
          - `Description`
          - `0`
            - None
          - `1`
            - Zone
          - `2`
            - Communities
          - `3`
            - Custom

**Returns:**
- `enabled`
  - *boolean*