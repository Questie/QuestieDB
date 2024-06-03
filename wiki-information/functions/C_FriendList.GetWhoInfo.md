## Title: C_FriendList.GetWhoInfo

**Content:**
Retrieves info about a character on your current /who list.
`info = C_FriendList.GetWhoInfo(index)`

**Parameters:**
- `index`
  - *number* - Index 1 up to `C_FriendList.GetNumWhoResults()`

**Returns:**
- `info`
  - *WhoInfo*
    - `Field`
    - `Type`
    - `Description`
    - `fullName`
      - *string* - Character-Realm name
    - `fullGuildName`
      - *string* - Guild name
    - `level`
      - *number*
    - `raceStr`
      - *string*
    - `classStr`
      - *string* - Localized class name
    - `area`
      - *string* - The character's current zone
    - `filename`
      - *string?* - Localization-independent classFilename
    - `gender`
      - *number* - Sex of the character. 2 for male, 3 for female

**Usage:**
```lua
local p = C_FriendList.GetWhoInfo(1)
print(format("%s (level %d %s %s) is in %s", p.fullName, p.level, p.raceStr, p.classStr, p.area))
-- Output: Nartan-Ravenholdt (level 43 Kul Tiran Druid) is in Eastern Plaguelands
```

**Reference:**
- `C_FriendList.SendWho()`
- `/who`