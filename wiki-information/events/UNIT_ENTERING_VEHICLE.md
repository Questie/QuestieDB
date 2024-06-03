## Event: UNIT_ENTERING_VEHICLE

**Title:** UNIT ENTERING VEHICLE

**Content:**
Fired as a unit is about to enter a vehicle, as compared to UNIT_ENTERED_VEHICLE which happens afterward.
`UNIT_ENTERING_VEHICLE: unitTarget, showVehicleFrame, isControlSeat, vehicleUIIndicatorID, vehicleGUID, mayChooseExit, hasPitch`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `showVehicleFrame`
  - *boolean*
- `isControlSeat`
  - *boolean*
- `vehicleUIIndicatorID`
  - *number*
- `vehicleGUID`
  - *string*
- `mayChooseExit`
  - *boolean*
- `hasPitch`
  - *boolean*