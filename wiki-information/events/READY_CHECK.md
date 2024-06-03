## Event: READY_CHECK

**Title:** READY CHECK

**Content:**
Fired when a Ready Check is performed by the raid (or party) leader.
`READY_CHECK: initiatorName, readyCheckTimeLeft`

**Payload:**
- `initiatorName`
  - *string*
- `readyCheckTimeLeft`
  - *number* - Time before automatic check completion in seconds (usually 30).