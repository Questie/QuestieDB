## Title: C_Club.GetClubMembers

**Content:**
Needs summary.
`members = C_Club.GetClubMembers(clubId)`

**Parameters:**
- `clubId`
  - *string*
- `streamId`
  - *string?*

**Returns:**
- `members`
  - *number*

**Description:**
This function retrieves the members of a specified club. The `clubId` is a unique identifier for the club, and the optional `streamId` can be used to filter members based on a specific stream within the club.

**Example Usage:**
```lua
local clubId = "1234567890"
local members = C_Club.GetClubMembers(clubId)
print("Number of members in the club:", members)
```

**Addons Using This Function:**
- **Communities**: The in-game Communities feature uses this function to display the list of members in a community or guild.
- **Guild Management Addons**: Addons like "Guild Roster Manager" use this function to fetch and display detailed information about guild members.