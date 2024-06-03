## Title: UnitSex

**Content:**
Returns the gender of the unit.
`gender = UnitSex(unit)`

**Parameters:**
- `unit`
  - *string* : UnitId

**Returns:**
- `sex`
  - *number?*
    - **ID** - **Gender**
    - 1 - Neutrum / Unknown
    - 2 - Male
    - 3 - Female

**Usage:**
```lua
local genders = {"unknown", "male", "female"}
if UnitExists("target") then
    print("The target is " .. genders[UnitSex("target")])
end
```

**Description:**
Most non-humanoid mobs/creatures will appear as Neutrum/Unknown.
Player characters currently appear as either Male or Female.

**Reference:**
- `C_PlayerInfo.GetSex()`