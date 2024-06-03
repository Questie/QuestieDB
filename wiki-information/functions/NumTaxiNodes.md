## Title: NumTaxiNodes

**Content:**
Returns the number of flight paths on the taxi map.
`numNodes = NumTaxiNodes()`

**Returns:**
- `numNodes`
  - *number* - total number of flight points on the currently open taxi map; 0 if the taxi map is not open.

**Description:**
Taxi information is only available while the taxi map is open -- between the `TAXIMAP_OPENED` and `TAXIMAP_CLOSED` events.

**Reference:**
- `TaxiNodeName`
- `TaxiNodePosition`
- `TakeTaxiNode`