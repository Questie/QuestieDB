## Title: SummonFriend

**Content:**
Summons a player using the RaF system.
`SummonFriend(guid, name)`

**Parameters:**
- `guid`
  - *string* : GUID - The guid of the player.
- `name`
  - *string* - The name of the player.

**Usage:**
Summons the current target if the target is a recruited friend.
`SummonFriend(UnitGUID("target"), UnitName("target"))`

**Reference:**
- `CanSummonFriend`
- `GetSummonFriendCooldown`