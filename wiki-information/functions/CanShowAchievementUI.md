## Title: CanShowAchievementUI

**Content:**
Returns if the AchievementUI can be displayed.
`canShow = CanShowAchievementUI()`

**Returns:**
- `canShow`
  - *boolean* - true if the achievement data is available (and hence the AchievementUI can be displayed), false otherwise.

**Description:**
This function returns false if called while the player is logging in (but not on subsequent UI reloads).
Achievement completion data is streamed to the client when the character logs in.
The streaming process is indicated by `RECEIVED_ACHIEVEMENT_LIST` events and generally completes before `PLAYER_LOGIN`.