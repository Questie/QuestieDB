## Title: C_Calendar.EventGetTextures

**Content:**
Needs summary.
`textures = C_Calendar.EventGetTextures(eventType)`

**Parameters:**
- `eventType`
  - *enum* - CalendarEventType
    - `Enum.CalendarEventType`
      - **Value**
      - **Field**
      - **Description**
      - `0`
        - Raid
      - `1`
        - Dungeon
      - `2`
        - PvP
      - `3`
        - Meeting
      - `4`
        - Other
      - `5`
        - HeroicDeprecated

**Returns:**
- `textures`
  - *structure* - CalendarEventTextureInfo
    - `Field`
    - `Type`
    - `Description`
    - `title`
      - *string*
    - `iconTexture`
      - *number*
    - `expansionLevel`
      - *number*
    - `difficultyId`
      - *number?*
    - `mapId`
      - *number?*
    - `isLfr`
      - *number?*