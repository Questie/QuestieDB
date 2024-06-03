## Event: UNIT_ENTERED_VEHICLE

**Title:** UNIT ENTERED VEHICLE

**Content:**
Fired once the unit is considered to be inside a vehicle, as compared to UNIT_ENTERING_VEHICLE which happens beforehand.
`UNIT_ENTERED_VEHICLE: unitTarget, showVehicleFrame, isControlSeat, vehicleUIIndicatorID, vehicleGUID, mayChooseExit, hasPitch`

**Payload:**
- `unitTarget`
  - *string* : UnitId
- `showVehicleFrame`
  - *boolean* - Vehicle has vehicle UI.
- `isControlSeat`
  - *boolean*
- `vehicleUIIndicatorID`
  - *number* - VehicleType (possible values are 'Natural' and 'Mechanical' and 'VehicleMount' and 'VehicleMount_Organic' or empty string).
- `vehicleGUID`
  - *string*
- `mayChooseExit`
  - *boolean*
- `hasPitch`
  - *boolean* - Vehicle can aim.