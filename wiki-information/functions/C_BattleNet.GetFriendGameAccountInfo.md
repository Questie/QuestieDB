## Title: C_BattleNet.GetFriendGameAccountInfo

**Content:**
Returns information on the game the Battle.net friend is playing.
```lua
gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(friendIndex, accountIndex)
gameAccountInfo = C_BattleNet.GetGameAccountInfoByID(id)
gameAccountInfo = C_BattleNet.GetGameAccountInfoByGUID(guid)
```

**Parameters:**
- **GetFriendGameAccountInfo:**
  - `friendIndex`
    - *number* - Index ranging from 1 to BNGetNumFriends()
  - `accountIndex`
    - *number* - Index ranging from 1 to C_BattleNet.GetFriendNumGameAccounts()

- **GetGameAccountInfoByID:**
  - `id`
    - *number* - `gameAccountInfo.gameAccountID`

- **GetGameAccountInfoByGUID:**
  - `guid`
    - *string* - `UnitGUID`

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

**BNET_CLIENT:**
- **Global**
  - `Value`
  - `Description`
  - `BNET_CLIENT_WOW`
    - WoW - World of Warcraft
  - `BNET_CLIENT_APP`
    - App - Battle.net desktop app
  - `BNET_CLIENT_HEROES`
    - Hero - Heroes of the Storm
  - `BNET_CLIENT_CLNT`
    - CLNT

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