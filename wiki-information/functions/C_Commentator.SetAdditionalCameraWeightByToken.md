## Title: C_Commentator.SetAdditionalCameraWeightByToken

**Content:**
Needs summary.
`C_Commentator.SetAdditionalCameraWeightByToken(unitToken, weight)`

**Parameters:**
- `unitToken`
  - *string* : UnitId
- `weight`
  - *number*

**Description:**
This function is used in the World of Warcraft API to set an additional camera weight for a specific unit identified by `unitToken`. The `weight` parameter determines the influence this unit has on the camera's behavior.

**Example Usage:**
This function can be used in custom addons or scripts that manage camera behavior during events such as PvP tournaments or raids, where certain units (like bosses or key players) need to be focused on more frequently by the camera.

**Addons:**
Large addons like "Blizzard Esports" might use this function to enhance the viewing experience during live broadcasts by dynamically adjusting the camera focus based on the importance of different units in the game.