## Title: C_QuestSession.GetAvailableSessionCommand

**Content:**
Needs summary.
`command = C_QuestSession.GetAvailableSessionCommand()`

**Returns:**
- `command`
  - *Enum.QuestSessionCommand*
    - `Enum.QuestSessionCommand`
      - `Value`
      - `Field`
      - `Description`
        - `0` - None
        - `1` - Start
        - `2` - Stop
        - `3` - SessionActiveNoCommand

**Example Usage:**
This function can be used to determine the current available command for a quest session. For instance, if you are developing an addon that manages quest sessions, you can use this function to check if a session can be started, stopped, or if there is no command available.

**Addon Usage:**
Large addons like "World Quest Tracker" might use this function to manage quest sessions more effectively, ensuring that players are aware of the current state of their quest sessions and can act accordingly.