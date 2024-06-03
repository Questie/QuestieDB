## Title: GetTrackingInfo

**Content:**
Returns tracking info by index.
`name, texture, active, category, nested = GetTrackingInfo(id)`

**Parameters:**
- `id`
  - *number* - tracking type index, ascending from 1 to `GetNumTrackingTypes()`.

**Returns:**
- `name`
  - *string* - Track name.
- `texture`
  - *number* - fileID for the Track texture.
- `active`
  - *boolean* - If the track is active, it will return 1 but otherwise nil.
- `category`
  - *string* - Track category, returns "spell" if the tracking method is a spell in the spellbook or "other" if it's a static tracking method.
- `nested`
  - *number* - Nesting level, returns -1 for items at the root level, TOWNSFOLK for items in the Townsfolk dropdown, and HUNTER_TRACKING for Hunter tracking spells.

**Usage:**
Gathers information for the first option on the tracking list and lists it in the default chatframe:
```lua
local name, texture, active, category = GetTrackingInfo(1);
DEFAULT_CHAT_FRAME:AddMessage(name.." ("..category..")");
```

Lists all tracking methods, name and category in the default chatframe:
```lua
local count = GetNumTrackingTypes();
for i=1,count do 
    local name, texture, active, category = GetTrackingInfo(i);
    DEFAULT_CHAT_FRAME:AddMessage(name.." ("..category..")");
end
```

**Description:**
If the player has tracking spells, those will only be accessible to this function after the player's spellbook has been loaded from the server: consider waiting for `PLAYER_LOGIN` before querying.