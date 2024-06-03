## Title: GuildRosterSetOfficerNote

**Content:**
Sets the officer note of a guild member.
`GuildRosterSetOfficerNote(index, Text)`

**Parameters:**
- `(index, "Text")`
  - `index`
    - The position a member is in the guild roster. This can be found by counting from the top down to the member or by selecting the member and using the `GetGuildRosterSelection()` function.
  - `Text`
    - Text to be set to the officer note of the index.

**Usage:**
```lua
GuildRosterSetOfficerNote(GetGuildRosterSelection(), "My Officer Note")
```

**Description:**
Color can be added to public notes, officer notes, guild info, and guild MOTD using UI Escape Sequences:
```lua
GuildRosterSetOfficerNote(GetGuildRosterSelection(), "|cFFFF0000This Looks Red!")
```
or
```lua
/script GuildRosterSetOfficerNote(GetGuildRosterSelection(), "\\124cFFFF0000This Looks Red!")
```
for in-game text editing.