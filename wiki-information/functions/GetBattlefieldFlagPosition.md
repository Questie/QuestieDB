## Title: GetBattlefieldFlagPosition

**Content:**
Used to position the flag icon on the world map and the battlefield minimap.
`flagX, flagY, flagToken = GetBattlefieldFlagPosition(index)`

**Parameters:**
- `index`
  - *number* - Index to get the flag position from

**Returns:**
- `flagX`
  - *number* - Position of the flag on the map.
- `flagY`
  - *number* - Position of the flag on the map.
- `flagToken`
  - *string* - Name of flag texture in `Interface\\WorldStateFrame\\`
    - In Warsong Gulch the names of the flag textures are the strings "AllianceFlag" and "HordeFlag".