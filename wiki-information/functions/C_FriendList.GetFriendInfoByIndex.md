## Title: C_FriendList.GetFriendInfo

**Content:**
Retrieves information about a person on your friends list.
```lua
info = C_FriendList.GetFriendInfo(name)
info = C_FriendList.GetFriendInfoByIndex(index)
```

**Parameters:**
- **GetFriendInfo:**
  - `name`
    - *string* - name of friend in the friend list.

- **GetFriendInfoByIndex:**
  - `index`
    - *number* - index of the friend, up to `C_FriendList.GetNumFriends()` limited to max 100.

**Returns:**
- `info`
  - *FriendInfo*
    - `Field`
    - `Type`
    - `Description`
    - `connected`
      - *boolean* - If the friend is online
    - `name`
      - *string*
    - `className`
      - *string?* - Friend's class, or "Unknown" (if offline)
    - `area`
      - *string?* - Current location, or "Unknown" (if offline)
    - `notes`
      - *string?*
    - `guid`
      - *string* - GUID, example: "Player-1096-085DE703"
    - `level`
      - *number* - Friend's level, or 0 (if offline)
    - `dnd`
      - *boolean* - If the friend's current status flag is DND
    - `afk`
      - *boolean* - If the friend's current status flag is AFK
    - `rafLinkType`
      - *Enum.RafLinkType*
    - `mobile`
      - *boolean*

- **Enum.RafLinkType**
  - `Value`
  - `Field`
  - `Description`
  - `0`
    - None
  - `1`
    - Recruit
  - `2`
    - Friend
  - `3`
    - Both

**Description:**
Friend information isn't necessarily automatically kept up to date. You can use `C_FriendList.ShowFriends()` to request an update from the server.

**Usage:**
```lua
local f = C_FriendList.GetFriendInfoByIndex(1)
print(format("Your friend %s (level %d %s) is in %s", f.name, f.level, f.className, f.area))
-- Your friend Aërto (level 74 Warrior) is in Sholazar Basin
```