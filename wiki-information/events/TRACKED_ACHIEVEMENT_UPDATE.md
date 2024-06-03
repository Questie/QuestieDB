## Event: TRACKED_ACHIEVEMENT_UPDATE

**Title:** TRACKED ACHIEVEMENT UPDATE

**Content:**
Fired when a timed event for an achievement begins or ends. The achievement does not have to be actively tracked for this to trigger.
`TRACKED_ACHIEVEMENT_UPDATE: achievementID, criteriaID, elapsed, duration`

**Payload:**
- `achievementID`
  - *number*
- `criteriaID`
  - *number?*
- `elapsed`
  - *number?* - Actual time
- `duration`
  - *number?* - Time limit