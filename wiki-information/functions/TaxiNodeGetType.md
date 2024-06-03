## Title: TaxiNodeGetType

**Content:**
Returns the type of a flight path node.
`type = TaxiNodeGetType(index)`

**Parameters:**
- `index`
  - *number* - Taxi map node index, ascending from 1 to NumTaxiNodes().

**Returns:**
- `type`
  - *string* - "CURRENT" for the player's current position, "REACHABLE" for nodes that can be travelled to, "DISTANT" for nodes that can't be travelled to, and "NONE" if the index is out of bounds.

**Description:**
Taxi information is only available while the taxi map is open -- between the TAXIMAP_OPENED and TAXIMAP_CLOSED events.

**Reference:**
- `TaxiNodeName`