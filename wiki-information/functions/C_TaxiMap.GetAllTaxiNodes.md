## Title: C_TaxiMap.GetAllTaxiNodes

**Content:**
Returns information on taxi nodes at the current flight master.
`taxiNodes = C_TaxiMap.GetAllTaxiNodes(uiMapID)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID

**Returns:**
- `taxiNodes`
  - *TaxiNodeInfo*
    - `Field`
    - `Type`
    - `Description`
    - `nodeID`
      - *number*
    - `position`
      - *vector2*
    - `name`
      - *string*
    - `state`
      - *Enum.FlightPathState*
    - `slotIndex`
      - *number*
    - `textureKit`
      - *string* - textureKit
    - `useSpecialIcon`
      - *boolean*
    - `specialIconCostString`
      - *string?*
    - `isMapLayerTransition`
      - *boolean*

**Enum.FlightPathState:**
- `Value`
- `Field`
- `Description`
  - `0`
    - Current
  - `1`
    - Reachable
  - `2`
    - Unreachable