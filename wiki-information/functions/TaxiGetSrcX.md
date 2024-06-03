## Title: TaxiGetSrcX

**Content:**
Returns the horizontal position of the source node of a given route to the destination.
`local sX = TaxiGetSrcX(destinationIndex, routeIndex)`

**Parameters:**
- `(destinationIndex, routeIndex)`
  - `destinationIndex`
    - *number* - The final destination taxi node.
  - `routeIndex`
    - *number* - The index of the route to get the source from.

**Returns:**
- `sX`
  - *number* - The horizontal position of the source node.