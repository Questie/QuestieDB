## Title: TaxiNodeCost

**Content:**
Returns the cost of the flight path in copper.
`cost = TaxiNodeCost(slot)`

**Parameters:**
- `slot`
  - *number* - 1 ascending to NumTaxiNodes(), out of bound numbers triggers lua error.

**Returns:**
- `cost`
  - *number* - returns the cost in copper, 0 if destination is undiscovered, free or current node.

**Usage:**
The following example will print the name and cost for each flight point that is not free.
```lua
for i = 1, NumTaxiNodes() do
  if (TaxiNodeCost(i) > 0) then
    print(format("Flight to %s costs: %s", TaxiNodeName(i), GetCoinText(TaxiNodeCost(i), " ")))
  end
end
```

**Description:**
Taxi information is only available while the taxi map is open -- between the TAXIMAP_OPENED and TAXIMAP_CLOSED events.
"invalid taxi node slot" is an error triggered by out-of-bound slot (0 or NumTaxiNodes() < slot) or if there is no taxi map open.
For some reason, this returns the original cost of the given slot, not taking into account any reductions you get due to faction.

**Reference:**
- `NumTaxiNodes()`
- `TaxiNodeGetType(slot)`
- `TaxiNodeName(slot)`