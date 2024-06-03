## Title: CanGuildDemote

**Content:**
Returns true if the player can demote guild members.
`canDemote = CanGuildDemote()`

**Returns:**
- `canDemote`
  - *boolean* - Returns true if the player can demote.

**Example Usage:**
This function can be used in a guild management addon to check if the current player has the permissions to demote other guild members. For instance, before displaying the demote option in a guild member's context menu, the addon can call `CanGuildDemote()` to ensure the player has the necessary permissions.

**Addons Using This Function:**
Large guild management addons like "Guild Roster Manager" may use this function to manage guild ranks and permissions effectively. It helps in ensuring that only players with the appropriate permissions can perform demotions within the guild.