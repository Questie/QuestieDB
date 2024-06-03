## Title: TimeoutResurrect

**Content:**
Signals the client that an offer to resurrect the player has expired.
`TimeoutResurrect()`

**Description:**
Called when the timeout timer on resurrection StaticPopups expires. Prior to patch 5.4.0, `DeclineResurrect` was used for both timed out and declined resurrection requests.

**Reference:**
- `AcceptResurrect`
- `DeclineResurrect`