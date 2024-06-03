## Title: BNGetFriendInfo

**Content:**
Returns information about the specified RealID friend.
```lua
bnetAccountID, accountName, battleTag, isBattleTagPresence, characterName, bnetIDGameAccount, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR, isReferAFriend, canSummonFriend
 = BNGetFriendInfo(friendIndex)
 = BNGetFriendInfoByID(bnetAccountID)
```

**Parameters:**
- **BNGetFriendInfo:**
  - `friendIndex`
    - *number* - The index on the friends list for this RealID friend, ranging from 1 to BNGetNumFriends()

- **BNGetFriendInfoByID:**
  - `bnetAccountID`
    - *number* - A unique numeric identifier for this friend's battle.net account for the current session

**Returns:**
- `bnetAccountID`
  - *number* - A temporary ID for the friend's battle.net account during this session.
- `accountName`
  - *string* - An escape sequence (starting with |K) representing the friend's full name or BattleTag name.
- `battleTag`
  - *string* - A nickname and number that when combined, form a unique string that identifies the friend (e.g., "Nickname#0001").
- `isBattleTagPresence`
  - *boolean* - Whether or not the friend is known by their BattleTag.
- `characterName`
  - *string* - The name of the logged in character.
- `bnetIDGameAccount`
  - *number* - A unique numeric identifier for the friend's game account during this session.
- `client`
  - *string* - See BNET_CLIENT
- `isOnline`
  - *boolean* - Whether or not the friend is online.
- `lastOnline`
  - *number* - The number of seconds elapsed since this friend was last online (from the epoch date of January 1, 1970). Returns nil if currently online.
- `isAFK`
  - *boolean* - Whether or not the friend is flagged as Away.
- `isDND`
  - *boolean* - Whether or not the friend is flagged as Busy.
- `messageText`
  - *string* - The friend's Battle.Net broadcast message.
- `noteText`
  - *string* - The contents of the player's note about this friend.
- `isRIDFriend`
  - *boolean* - Returns true for RealID friends and false for BattleTag friends.
- `messageTime`
  - *number* - The number of seconds elapsed since the current broadcast message was sent.
- `canSoR`
  - *boolean* - Whether or not this friend can receive a Scroll of Resurrection.
- `isReferAFriend`
  - *boolean*
- `canSummonFriend`
  - *boolean*

**Description:**
BNET_CLIENT
- **Global**
  - **Value**
  - **Description**
  - `BNET_CLIENT_WOW`
    - WoW
    - World of Warcraft
  - `BNET_CLIENT_APP`
    - App
    - Battle.net desktop app
  - `BNET_CLIENT_HEROES`
    - Hero
    - Heroes of the Storm
  - `BNET_CLIENT_CLNT`
    - CLNT

**Reference:**
- `BNGetFriendGameAccountInfo`
- `BNGetGameAccountInfo`