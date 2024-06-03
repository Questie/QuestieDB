## Title: GetCurrentRegion

**Content:**
Returns a numeric ID representing the region the player is currently logged into.
`regionID = GetCurrentRegion()`

**Returns:**
The following region IDs are known:
- `ID`
  - `Description`
- `1`
  - US (includes Brazil and Oceania)
- `2`
  - Korea
- `3`
  - Europe (includes Russia)
- `4`
  - Taiwan (see Details)
- `5`
  - China

**Description:**
The value returned is deduced from the portal console variable, which may be set by the game client at launch to match the selected account region in the Battle.net desktop application. It does not necessarily indicate the region of the realm that the player is logged into, but instead the region of the Battle.net portal used to contact the login servers and provide a realm list.
This function is mostly reliable except in the case where the user modifies the portal from the login screen after having launched the game client through the Battle.net desktop application. The game client will prefer to use the login server addresses specified by the desktop application over the portal, causing a mismatch between the logged in region and what this function will report.
Realms located in Taiwan use the Korean Battle.net portal, meaning this function will typically always report the current region as being Korea rather than Taiwan when connected to these realms. Other functions like `C_BattleNet.GetFriendAccountInfo` may however return region IDs that correctly identify Taiwanese realms.

**Notes and Caveats:**
The following snippet demonstrates use of this API in conjunction with `C_BattleNet.GetGameAccountInfoByGUID` to more reliably obtain the current region ID of the player.
```lua
local function GetActualRegion()
  local gameAccountInfo = C_BattleNet.GetGameAccountInfoByGUID(UnitGUID("player"))
  return gameAccountInfo and gameAccountInfo.regionID or GetCurrentRegion()
end
print(GetActualRegion())
```

**Reference:**
`GetCurrentRegionName`