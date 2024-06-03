## Title: C_FriendList.AddIgnore

**Content:**
Adds a player to your ignore list.
`added = C_FriendList.AddIgnore(name)`

**Parameters:**
- `name`
  - *string* - the name of the player you would like to ignore.

**Returns:**
- `added`
  - *boolean* - whether the player was successfully added to your ignore list. This seems to only return false when trying to ignore someone who is already being ignored, otherwise true.

**Description:**
You can have a maximum of 50 people on your ignore list at the same time.
The player being ignored does not need to be online for this to work.
Calling this function when a player is already ignored, removes the ignore.