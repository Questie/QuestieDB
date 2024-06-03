## Title: C_Calendar.EventSetType

**Content:**
Sets the event type for the current calendar event.
`C_Calendar.EventSetType(typeIndex)`

**Parameters:**
- `typeIndex`
  - *enum* - CalendarEventType
    - `Enum.CalendarEventType`
      - `Value`
      - `Field`
      - `Description`
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

**Description:**
The calendar event must be previously opened with `C_Calendar.OpenEvent` or an event candidate from `C_Calendar.CreatePlayerEvent`.
The calendar event is updated with `C_Calendar.UpdateEvent` or created with `C_Calendar.AddEvent`.
If the event type is not set before creating with `C_Calendar.AddEvent`, it defaults to 1.