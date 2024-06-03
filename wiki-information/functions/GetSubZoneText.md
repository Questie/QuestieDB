## Title: GetSubZoneText

**Content:**
Returns the subzone name.
`subzone = GetSubZoneText()`

**Returns:**
- `subzone`
  - *string* - Subzone name or an empty string (if not in a subzone).

**Usage:**
Returns the subzone name where the player is currently located. If not in a subzone, it returns an empty string.
```lua
/run print("Current SubZone: " .. GetSubZoneText())
```

**Description:**
Related Events
- `ZONE_CHANGED_INDOORS`