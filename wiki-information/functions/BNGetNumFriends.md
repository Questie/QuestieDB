## Title: BNGetNumFriends

**Content:**
Returns the amount of (online) Battle.net friends.
`numBNetTotal, numBNetOnline, numBNetFavorite, numBNetFavoriteOnline = BNGetNumFriends()`

**Returns:**
- `numBNetTotal`
  - *number* - amount of Battle.net friends on the friends list
- `numBNetOnline`
  - *number* - online Battle.net friends
- `numBNetFavorite`
  - *number* - favorite battle.net friends
- `numBNetFavoriteOnline`
  - *number* - favorite online battle.net friends

**Usage:**
```lua
local total, online = BNGetNumFriends()
print("You have "..total.." Battle.net friends and "..online.." of them are online!")
```