## Event: COMPANION_UPDATE

**Title:** COMPANION UPDATE

**Content:**
Fired when companion info updates.
`COMPANION_UPDATE: companionType`

**Payload:**
- `companionType`
  - *string?*

**Content Details:**
If the type is nil, the UI should update if it's visible, regardless of which type it's managing. If the type is non-nil, then it will be either "CRITTER" or "MOUNT" and that signifies that the active companion has changed and the UI should update if it's currently showing that type.
"Range" appears to be at least 40 yards. If you are in a major city, expect this event to fire constantly.
This event fires when any of the following conditions occur:
- You, or anyone within range, summons or dismisses a critter
- You, or anyone within range, mounts or dismounts
- Someone enters range with a critter summoned
- Someone enters range while mounted