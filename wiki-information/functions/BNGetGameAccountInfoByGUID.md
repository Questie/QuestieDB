## Title: C_BattleNet.GetFriendGameAccountInfo

**Content:**
Returns information on the game the Battle.net friend is playing.
```lua
gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(friendIndex, accountIndex)
gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(id)
gameAccountInfo = C_BattleNet.GetGameAccountInfoByGUID(guid)
```

**Parameters:**

*GetFriendGameAccountInfo:*
- `friendIndex`
  - *number* - Index ranging from 1 to BNGetNumFriends()
- `accountIndex`
  - *number* - Index ranging from 1 to C_BattleNet.GetFriendNumGameAccounts()

*GetGameAccountInfoByID:*
- `id`
  - *number* - gameAccountInfo.gameAccountID

*GetGameAccountInfoByGUID:*
- `guid`
  - *string* - UnitGUID

**Returns:**
- `gameAccountInfo`
  - *BNetGameAccountInfo?*
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
      - *number?* - The ID for the logged in realm
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
Related API: `C_BattleNet.GetFriendAccountInfo`

**Usage:**
Shows your Battle.net friends' game information. Tested with one friend online in the mobile app, and one friend offline.
```lua
for i = 1, BNGetNumFriends() do
    for j = 1, C_BattleNet.GetFriendNumGameAccounts(i) do
        local game = C_BattleNet.GetFriendGameAccountInfo(i, j)
        print(game.gameAccountID, game.isOnline, game.clientProgram)
    end
end
-- 5, true, "BSAp"

C_BattleNet.GetFriendAccountInfo() returns the same information in gameAccountInfo
for i = 1, BNGetNumFriends() do
    local game = C_BattleNet.GetFriendAccountInfo(i).gameAccountInfo
    print(game.gameAccountID, game.isOnline, game.clientProgram)
end
-- 5, true, "BSAp"
-- nil, false, ""
```

**Example Usage:**
This function can be used to display detailed information about the games your Battle.net friends are currently playing. For instance, you can create an addon that lists all your friends' current activities across different Blizzard games.

**Addons Using This API:**
- **ElvUI**: This popular UI overhaul addon uses this API to display detailed information about Battle.net friends in its social module.
- **WeakAuras**: This addon can use this API to trigger custom alerts based on the online status or game activity of Battle.net friends.