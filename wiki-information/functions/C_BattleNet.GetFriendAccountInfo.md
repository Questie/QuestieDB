## Title: C_BattleNet.GetFriendAccountInfo

**Content:**
Returns information about a Battle.net friend account.
```lua
accountInfo = C_BattleNet.GetFriendAccountInfo(friendIndex)
accountInfo = C_BattleNet.GetAccountInfoByID(id)
accountInfo = C_BattleNet.GetAccountInfoByGUID(guid)
```

**Parameters:**

*GetFriendAccountInfo:*
- `friendIndex`
  - *number* - Index ranging from 1 to BNGetNumFriends()
- `wowAccountGUID`
  - *string?* - BNetAccountGUID

*GetAccountInfoByID:*
- `id`
  - *number* - bnetAccountID
- `wowAccountGUID`
  - *string?* - BNetAccountGUID

*GetAccountInfoByGUID:*
- `guid`
  - *string* - UnitGUID

**Returns:**
- `accountInfo`
  - *BNetAccountInfo?*
    - `Field`
    - `Type`
    - `Description`
    - `bnetAccountID`
      - *number* - A temporary ID for the friend's battle.net account during this session
    - `accountName`
      - *string* - A protected string representing the friend's full name or BattleTag name
    - `battleTag`
      - *string* - The friend's BattleTag (e.g., "Nickname#0001")
    - `isFriend`
      - *boolean*
    - `isBattleTagFriend`
      - *boolean* - Whether or not the friend is known by their BattleTag
    - `lastOnlineTime`
      - *number* - The number of seconds elapsed since this friend was last online (from the epoch date of January 1, 1970). Returns nil if currently online.
    - `isAFK`
      - *boolean* - Whether or not the friend is flagged as Away
    - `isDND`
      - *boolean* - Whether or not the friend is flagged as Busy
    - `isFavorite`
      - *boolean* - Whether or not the friend is marked as a favorite by you
    - `appearOffline`
      - *boolean*
    - `customMessage`
      - *string* - The Battle.net broadcast message
    - `customMessageTime`
      - *number* - The number of seconds elapsed since the current broadcast message was sent
    - `note`
      - *string* - The contents of the player's note about this friend
    - `rafLinkType`
      - *Enum.RafLinkType*
    - `gameAccountInfo`
      - *BNetGameAccountInfo*
        - `Field`
        - `Type`
        - `Description`
        - `gameAccountID`
          - *number?* - A temporary ID for the friend's battle.net game account during this session.
        - `clientProgram`
          - *string* - BNET_CLIENT
        - `isOnline`
          - *boolean*
        - `isGameBusy`
          - *boolean*
        - `isGameAFK`
          - *boolean*
        - `wowProjectID`
          - *number?*
        - `characterName`
          - *string?* - The name of the logged in toon/character
        - `realmName`
          - *string?* - The name of the logged in realm
        - `realmDisplayName`
          - *string?*
        - `realmID`
          - *number?*
        - `factionName`
          - *string?* - The englishFaction name (i.e., "Alliance" or "Horde")
        - `raceName`
          - *string?* - The localized race name (e.g., "Blood Elf")
        - `className`
          - *string?* - The localized class name (e.g., "Death Knight")
        - `areaName`
          - *string?* - The localized zone name (e.g., "The Undercity")
        - `characterLevel`
          - *number?* - The current level (e.g., "90")
        - `richPresence`
          - *string?* - For WoW, returns "zoneName - realmName". For StarCraft 2 and Diablo 3, returns the location or activity the player is currently engaged in.
        - `playerGuid`
          - *string?* - A unique numeric identifier for the friend's character during this session.
        - `isWowMobile`
          - *boolean*
        - `canSummon`
          - *boolean*
        - `hasFocus`
          - *boolean* - Whether or not this toon is the one currently being displayed in Blizzard's FriendFrame
        - `regionID`
          - *number* - Added in 9.1.0
        - `isInCurrentRegion`
          - *boolean* - Added in 9.1.0

**Description:**
Related API: `C_BattleNet.GetFriendGameAccountInfo`

**Usage:**
Shows your own account info.
```lua
/dump C_BattleNet.GetAccountInfoByID(select(3, BNGetInfo()))
```
Shows your Battle.net friends' account information.
```lua
for i = 1, BNGetNumFriends() do
    local acc = C_BattleNet.GetFriendAccountInfo(i)
    local game = acc.gameAccountInfo
    print(acc.bnetAccountID, acc.accountName, game.gameAccountID, game.isOnline, game.clientProgram)
end
-- 1, "|Kq2|k", 5, true, "BSAp"
-- 2, "|Kq1|k", nil, false, ""
```