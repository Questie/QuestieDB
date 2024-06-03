## Title: RequestRaidInfo

**Content:**
Requests which instances the player is saved to.
`RequestRaidInfo()`

**Reference:**
- `UPDATE_INSTANCE_INFO`
  - When your query has finished processing on the server and the raid info is available.

**Example Usage:**
This function can be used in an addon to check which raid instances a player is currently saved to. For example, an addon could call `RequestRaidInfo()` and then listen for the `UPDATE_INSTANCE_INFO` event to update a UI element displaying the player's raid lockouts.

**Addon Usage:**
Many raid management addons, such as "SavedInstances," use this function to track and display the raid lockout status of all characters on an account. This helps players manage their raid schedules and avoid missing out on loot opportunities.