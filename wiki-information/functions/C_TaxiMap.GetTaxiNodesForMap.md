## Title: C_TaxiMap.GetTaxiNodesForMap

**Content:**
Returns information on taxi nodes for a given map, without considering the current flight master.
`mapTaxiNodes = C_TaxiMap.GetTaxiNodesForMap(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `mapTaxiNodes`
  - *MapTaxiNodeInfo*
    - `Field`
    - `Type`
    - `Description`
    - `nodeID`
      - *number*
    - `position`
      - *Vector2DMixin*
    - `name`
      - *string*
    - `atlasName`
      - *string* - AtlasID
    - `faction`
      - *Enum.FlightPathFaction*
    - `textureKit`
      - *string*

**Enum.FlightPathFaction Values:**
- `Field`
- `Description`
- `0`
  - Neutral
- `1`
  - Horde
- `2`
  - Alliance