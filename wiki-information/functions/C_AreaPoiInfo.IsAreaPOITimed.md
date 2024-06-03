## Title: C_AreaPoiInfo.IsAreaPOITimed

**Content:**
Returns whether an area poi is timed.
`isTimed, hideTimerInTooltip = C_AreaPoiInfo.IsAreaPOITimed(areaPoiID)`

**Parameters:**
- `areaPoiID`
  - *number*

**Returns:**
- `isTimed`
  - *boolean*
- `hideTimerInTooltip`
  - *boolean?*

**Description:**
This statically determines if the POI is timed, `GetAreaPOITimeLeft` retrieves the value from the server and may return nothing for long intervals.