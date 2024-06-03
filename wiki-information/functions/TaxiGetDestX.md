## Title: TaxiGetDestX

**Content:**
Returns the horizontal position of the destination node of a given route to the destination.
`local dX = TaxiGetDestX(destinationIndex, routeIndex)`

**Parameters:**
- `(destinationIndex, routeIndex)`
  - `destinationIndex`
    - *number* - The final destination taxi node.
  - `routeIndex`
    - *number* - The index of the route to get the source from.

**Returns:**
- `dX`
  - *number* - The horizontal position of the destination node for the route.