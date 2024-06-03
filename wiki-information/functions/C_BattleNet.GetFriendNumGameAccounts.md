## Title: C_BattleNet.GetFriendNumGameAccounts

**Content:**
Returns the number of game accounts for the Battle.net friend.
`numGameAccounts = C_BattleNet.GetFriendNumGameAccounts(friendIndex)`

**Parameters:**
- `friendIndex`
  - *number* - The Battle.net friend's index on the friends list ranging from 1 to `BNGetNumFriends()`

**Returns:**
- `numGameAccounts`
  - *number* - The number of accounts or 0 if the friend is not online.

**Description:**
This function returns the number of ACCOUNTS a player has that are identified with a given BattleTag ID rather than the number of characters on a given account.