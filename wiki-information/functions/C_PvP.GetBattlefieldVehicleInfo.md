## Title: C_PvP.GetBattlefieldVehicleInfo

**Content:**
Returns battleground vehicle info.
`info = C_PvP.GetBattlefieldVehicleInfo(vehicleIndex, uiMapID)`

**Parameters:**
- `vehicleIndex`
  - *number*
- `uiMapID`
  - *number* : UiMapID

**Returns:**
- `info`
  - *BattlefieldVehicleInfo*
    - `Field`
    - `Type`
    - `Description`
    - `x`
      - *number*
    - `y`
      - *number*
    - `name`
      - *string*
    - `isOccupied`
      - *boolean*
    - `atlas`
      - *string*
    - `textureWidth`
      - *number*
    - `textureHeight`
      - *number*
    - `facing`
      - *number*
    - `isPlayer`
      - *boolean*
    - `isAlive`
      - *boolean*
    - `shouldDrawBelowPlayerBlips`
      - *boolean*