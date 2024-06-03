## Title: UnitPowerType

**Content:**
Returns a number corresponding to the power type (e.g., mana, rage, or energy) of the specified unit.
`powerType, powerTypeToken, rgbX, rgbY, rgbZ = UnitPowerType(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken - The unit whose power type to query.
- `index`
  - *number?* = 0 - Optional value for classes with multiple powerTypes. If not specified, information about the first (currently active) power type will be returned.

**Returns:**
- `powerType`
  - *Enum.PowerType* - the ID corresponding to the unit's queried power type.
- `powerToken`
  - *string* - also the power type:
    - "MANA"
    - "RAGE"
    - "FOCUS"
    - "ENERGY"
    - "HAPPINESS"
    - "RUNES"
    - "RUNIC_POWER"
    - "SOUL_SHARDS"
    - "ECLIPSE"
    - "HOLY_POWER"
    - "AMMOSLOT" (vehicles, 3.1)
    - "FUEL" (vehicles, 3.1)
    - "STAGGER" (vehicles, 5.1)
    - "CHI"
    - "INSANITY"
    - "ARCANE_CHARGES"
    - "FURY"
    - "PAIN"
- `rgbX`
  - *number* - Alternative red component for this power type, see details. Nil for most of the standard power types.
- `rgbY`
  - *number* - Alternative green component for this power type, see details. Nil for most of the standard power types.
- `rgbZ`
  - *number* - Alternative blue component for this power type, see details. Nil for most of the standard power types.

**Usage:**
The following snippet displays the player's current mana/rage/energy/etc in the default chat frame.
```lua
local t = { [0] = "mana", [1] = "rage", [2] = "focus", [3] = "energy", [4] = "happiness", [5] = "runes", [6] = "runic power", [7] = "soul shards", [8] = "eclipse", [9] = "holy power"}
print(UnitName("player") .. "'s " .. t[UnitPowerType("player")] .. ": " .. UnitPower("player"))
```

**Description:**
Colors of all typical power types are stored in the `PowerBarColor` global table. Some special types may implement their own color as returned by the 3rd to 5th return values of `UnitPowerType`. For most of the standard power types, they return nil however. FrameXML implements it the following way (with a fallback to "MANA"):
```lua
local powerType, powerToken, altR, altG, altB = UnitPowerType(UnitId);
local info = PowerBarColor[powerToken];

if ( info ) then
  -- The PowerBarColor takes priority
  r, g, b = info.r, info.g, info.b;
elseif ( not altR ) then
  -- Couldn't find a power token entry. Default to indexing by power type or just mana if we don't have that either.
  info = PowerBarColor[powerType] or PowerBarColor["MANA"];
  r, g, b = info.r, info.g, info.b;
else
  r, g, b = altR, altG, altB;
end
```

**Reference:**
- `UnitPower`
- `UnitPowerMax`