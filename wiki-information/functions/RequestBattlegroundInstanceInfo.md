## Title: RequestBattlegroundInstanceInfo

**Content:**
Requests the available instances of a battleground.
`RequestBattlegroundInstanceInfo(index)`

**Parameters:**
- `index`
  - *number* - Index of the battleground type to request instance information for; valid indices start from 1 and go up to `GetNumBattlegroundTypes()`.

**Reference:**
- `PVPQUEUE_ANYWHERE_SHOW` is fired when the requested information becomes available.
- **See Also:**
  - `GetNumBattlefields`
  - `GetBattlefieldInfo`

**Description:**
Calling `JoinBattlefield` after calling this function, but before `PVPQUEUE_ANYWHERE_SHOW`, will fail silently; you must wait for the instance list to become available before you can queue for an instance.