## Title: C_LFGList.GetActivityInfoExpensive

**Content:**
Returns the zone associated with an activity.
`currentArea = C_LFGList.GetActivityInfoExpensive(activityID)`

**Parameters:**
- `activityID`
  - *number* - The activityID for which information is requested, as returned by `C_LFGList.GetAvailableActivities()`.

**Returns:**
- `currentArea`
  - *boolean* - True if you are in the zone of the activity, false otherwise.