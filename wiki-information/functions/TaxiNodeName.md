## Title: TaxiNodeName

**Content:**
Returns the name of a flight path node.
`name = TaxiNodeName(index)`

**Parameters:**
- `index`
  - *number* - Index of the taxi map node, ascending from 1 to `NumTaxiNodes()`

**Returns:**
- `name`
  - *string* - name of the specified flight point, or "INVALID" if the index is out of bounds.

**Description:**
Taxi information is only available while the taxi map is open -- between the `TAXIMAP_OPENED` and `TAXIMAP_CLOSED` events.