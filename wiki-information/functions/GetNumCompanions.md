## Title: GetNumCompanions

**Content:**
Returns the number of mounts.
`count = GetNumCompanions(type)`

**Parameters:**
- `type`
  - *string* - Type of companions to count: "CRITTER", or "MOUNT".

**Returns:**
- `count`
  - *number* - The number of companions of a specific type.

**Usage:**
The following snippet prints how many mounts the player has collected.
```lua
local count = GetNumCompanions("MOUNT");
print('Hello, I have collected a total of ' .. count .. ' mounts.');
```