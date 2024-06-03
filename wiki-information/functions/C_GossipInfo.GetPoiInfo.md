## Title: C_GossipInfo.GetPoiInfo

**Content:**
Returns info for a gossip point of interest (e.g. the red flags when asking city guards for directions).
`gossipPoiInfo = C_GossipInfo.GetPoiInfo(uiMapID, gossipPoiID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID
- `gossipPoiID`
  - *number*

**Returns:**
- `gossipPoiInfo`
  - *GossipPoiInfo?*
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string*
    - `textureIndex`
      - *number* - Used for `GetPOITextureCoords()`
    - `position`
      - *Vector2DMixin*
    - `inBattleMap`
      - *boolean*