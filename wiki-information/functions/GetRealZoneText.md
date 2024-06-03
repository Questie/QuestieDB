## Title: GetRealZoneText

**Content:**
Returns the map instance name.
`zone = GetRealZoneText()`

**Parameters:**
- `instanceID`
  - *number?* : InstanceID - When omitted, returns current instanceID name.

**Returns:**
- `zone`
  - *string* - The name of the map instance.

**Description:**
Returns the name of the map instance which can be different from `GetZoneText()`.
The returned zone name is localized to the game client's language.

**Usage:**
Returns the current zone.
```lua
/dump GetRealZoneText()
> "Stormwind City"
```
Returns the name of a specific instanceID.
```lua
/dump GetRealZoneText(451)
> "Development Land"
```