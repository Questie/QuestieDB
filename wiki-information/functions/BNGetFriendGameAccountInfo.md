## Title: BNGetFriendGameAccountInfo

**Content:**
Returns information about the specified toon of a RealID friend.
```
hasFocus, characterName, client, realmName, realmID, faction, race, class, guild, zoneName, level, gameText, broadcastText, broadcastTime, canSoR, toonID, bnetIDAccount, isGameAFK, isGameBusy
= BNGetFriendGameAccountInfo(friendIndex)
= BNGetGameAccountInfo(bnetIDGameAccount)
= BNGetGameAccountInfoByGUID(guid)
```

**Parameters:**
- **BNGetFriendGameAccountInfo:**
  - `friendIndex`
    - *number* - Ranging from 1 to BNGetNumFriendGameAccounts()

- **BNGetGameAccountInfo:**
  - `bnetIDGameAccount`
    - *number* - A unique numeric identifier for the friend during this session.

- **BNGetGameAccountInfoByGUID:**
  - `guid`
    - *string*

**Returns:**
- `hasFocus`
  - *boolean* - Whether or not this toon is the one currently being displayed in Blizzard's FriendFrame.
- `characterName`
  - *string* - The name of the logged in toon/character.
- `client`
  - *string* - Either "WoW" (BNET_CLIENT_WOW), "S2" (BNET_CLIENT_S2), "WTCG" (BNET_CLIENT_WTCG), "App" (BNET_CLIENT_APP), "Hero" (BNET_CLIENT_HEROES), "Pro" (BNET_CLIENT_OVERWATCH), "CLNT" (BNET_CLIENT_CLNT), or "D3" (BNET_CLIENT_D3) for World of Warcraft, StarCraft 2, Hearthstone, BNet Application, Heroes of the Storm, Overwatch, another client, or Diablo 3.
- `realmName`
  - *string* - The name of the logged in realm.
- `realmID`
  - *number* - The ID for the logged in realm.
- `faction`
  - *string* - The faction name (i.e., "Alliance" or "Horde").
- `race`
  - *string* - The localized race name (e.g., "Blood Elf").
- `class`
  - *string* - The localized class name (e.g., "Death Knight").
- `guild`
  - *string* - Seems to return "" even if the player is in a guild.
- `zoneName`
  - *string* - The localized zone name (e.g., "The Undercity").
- `level`
  - *string* - The current level (e.g., "90").
- `gameText`
  - *string* - For WoW, returns "zoneName - realmName". For StarCraft 2 and Diablo 3, returns the location or activity the player is currently engaged in.
- `broadcastText`
  - *string* - The Battle.Net broadcast message.
- `broadcastTime`
  - *number* - The number of seconds elapsed since the current broadcast message was sent.
- `canSoR`
  - *boolean* - Whether or not this friend can receive a Scroll of Resurrection.
- `toonID`
  - *number* - A unique numeric identifier for the friend's character during this session.
- `bnetIDAccount`
  - *number*
- `isGameAFK`
  - *boolean*
- `isGameBusy`
  - *boolean*

**Usage:**
```lua
local bnetIDGameAccount = select(6, BNGetFriendInfo(1)) -- assuming friend index 1 is me (Grdn)
local _, characterName, _, realmName = BNGetGameAccountInfo(bnetIDGameAccount)
print(toonName .. " plays on " .. realmName) -- Grdn plays on Onyxia
```

**Example Use Case:**
This function can be used to display detailed information about a RealID friend's current game status, such as their character name, realm, and current activity. This is particularly useful for addons that enhance the social experience in World of Warcraft by providing more detailed friend information.

**Addons Using This Function:**
- **ElvUI**: A comprehensive UI replacement addon that uses this function to display detailed information about RealID friends in its enhanced friend list.
- **Prat**: A chat enhancement addon that uses this function to show detailed RealID friend information in the chat window.