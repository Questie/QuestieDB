## Title: C_GuildInfo.GetGuildTabardInfo

**Content:**
Needs summary.
`tabardInfo = C_GuildInfo.GetGuildTabardInfo(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId

**Returns:**
- `tabardInfo`
  - *structure* - GuildTabardInfo (nilable)
    - `GuildTabardInfo`
      - `Field`
      - `Type`
      - `Description`
      - `backgroundColor`
        - *ColorMixin*
      - `borderColor`
        - *ColorMixin*
      - `emblemColor`
        - *ColorMixin*
      - `emblemFileID`
        - *number* - GuildEmblem.db2
      - `emblemStyle`
        - *number*

**Example Usage:**
This function can be used to retrieve the tabard information of a guild, which can be useful for displaying guild tabards in custom UI elements or addons.

**Addons:**
Large addons like "ElvUI" and "Guild Roster Manager" might use this function to display guild tabard information in their custom guild interfaces.