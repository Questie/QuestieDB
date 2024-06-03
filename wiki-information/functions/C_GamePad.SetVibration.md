## Title: C_GamePad.SetVibration

**Content:**
Makes the gamepad vibrate.
`C_GamePad.SetVibration(vibrationType, intensity)`

**Parameters:**
- `vibrationType`
  - *string* 
- `intensity`
  - *number* 

**Description:**
Vibration duration lasts for around 1 second.
"Trigger" type vibrations appear to be only supported by the PS5 controller, as trigger haptic vibration.

**Usage:**
Vibrates the gamepad at 100% intensity.
`C_GamePad.SetVibration("High", 1)`