## Title: BNGetNumFriendGameAccounts

**Content:**
Returns the specified Battle.net friend's number of toons.
`numGameAccounts = BNGetNumFriendGameAccounts(friendIndex)`

**Parameters:**
- `friendIndex`
  - *number* - The Battle.net friend's index on the friends list.

**Returns:**
- `numGameAccounts`
  - *number* - The number of accounts or 0 if the friend is not online.

**Description:**
This function returns the number of ACCOUNTS a player has that are identified with a given BattleTag ID rather than the number of characters on a given account.