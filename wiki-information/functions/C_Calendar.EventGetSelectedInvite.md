## Title: C_Calendar.EventGetSelectedInvite

**Content:**
Needs summary.
`inviteIndex = C_Calendar.EventGetSelectedInvite()`

**Returns:**
- `inviteIndex`
  - *number?*

**Description:**
This function is used to get the index of the selected invite in the calendar event. The exact use case and return type are not well-documented, but it is typically used in the context of managing calendar events and invites.

**Example Usage:**
```lua
local inviteIndex = C_Calendar.EventGetSelectedInvite()
if inviteIndex then
    print("Selected invite index: " .. inviteIndex)
else
    print("No invite selected.")
end
```

**Addons:**
Large addons that manage calendar events, such as "Group Calendar" or "Guild Event Manager," might use this function to handle invites to events.