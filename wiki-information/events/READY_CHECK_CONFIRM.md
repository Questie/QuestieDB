## Event: READY_CHECK_CONFIRM

**Title:** READY CHECK CONFIRM

**Content:**
Fired when a player confirms ready status.
`READY_CHECK_CONFIRM: unitTarget, isReady`

**Payload:**
- `unitTarget`
  - *string* : UnitId - The unit in raidN, partyN format. Fires twice if the confirming player is in your raid sub-group.
- `isReady`
  - *boolean*