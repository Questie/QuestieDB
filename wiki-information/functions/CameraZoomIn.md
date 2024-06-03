## Title: CameraZoomIn

**Content:**
Zooms the camera in.
`CameraZoomIn(increment)`

**Parameters:**
- `(float increment)`

**Description:**
Zooms the camera into the viewplane by increment. The increment must be between 0.0 and 50 with 0.0 indicating no zoom relative to current view and 50 being maximum zoom. From a completely zoomed out position, an increment of 50 will result in a first person camera angle.

As of patch 1.9.0, if the 'Interface Options > Advanced Options > Max Camera Distance' setting is set to Low, then the largest value for increment is 15. If this setting is set to High, then the largest value for increment is 30. With `/console CVar_cameraDistanceMaxFactor` the maximum value is 50.