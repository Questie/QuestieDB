## Title: C_PlayerInfo.UnitIsSameServer

**Content:**
Returns true if a player is from the same or connected realm.
`unitIsSameServer = C_PlayerInfo.UnitIsSameServer(playerLocation)`

**Parameters:**
- `playerLocation`
  - *PlayerLocationMixin*

**Returns:**
- `unitIsSameServer`
  - *boolean*

**Usage:**
Shows if your target is on the same (connected) realm.
```lua
/dump C_PlayerInfo.UnitIsSameServer(PlayerLocation:CreateFromUnit("target"))
```

**Reference:**
- `UnitIsSameServer`