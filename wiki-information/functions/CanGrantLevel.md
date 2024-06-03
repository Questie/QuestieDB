## Title: CanGrantLevel

**Content:**
Returns whether you can grant levels to a particular player.
`status = CanGrantLevel(unit)`

**Parameters:**
- `unit`
  - *string* - UnitId

**Returns:**
- `status`
  - *boolean* - true if you can grant levels to the unit; nil otherwise (unit is not RAF-linked to you, does not meet level requirements, or you are out of levels to grant).

**Usage:**
The snippet below prints whether you can grant levels to your target right now.
```lua
local status = CanGrantLevel("target")
if status then
  print("I can grant levels to my friend!")
else
  print("I am out of free levels for now.")
end
```