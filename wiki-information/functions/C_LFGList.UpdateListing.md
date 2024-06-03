## Title: C_LFGList.UpdateListing

**Content:**
Updates information for the players' currently listed group.
```lua
-- Retail
C_LFGList.UpdateListing(activityID, itemLevel, honorLevel, autoAccept, privateGroup) 
-- Classic
C_LFGList.UpdateListing(activityIDs)
```

**Parameters:**

**Retail:**
- `activityID`
  - *number* - Activity ID to register the group for.
- `itemLevel`
  - *number* - Minimum required item level for group applicants.
- `honorLevel`
  - *number* - Minimum required honor level for group applicants.
- `autoAccept`
  - *boolean* - If true, new applicants will be automatically invited to join the group.
- `privateGroup`
  - *boolean* - If true, the listing will only be visible to friends and guild members of players inside the group.
- `questID`
  - *number?* - Optional quest ID to associate with the group listing.
- `mythicPlusRating`
  - *number?* - Optional mythic plus rating needed to signup to the group listing.
- `pvpRating`
  - *number?* - Optional pvp rating needed to signup to the group listing.
- `selectedPlaystyle`
  - *number?* - Refers to Enum.LFGEntryPlaystyle values.
- `isCrossFaction`
  - *boolean = true* - Optional. If false, the group listing will not be visible to players of the opposite faction. If nil, true will be assumed.

**Classic:**
- `activityIDs`
  - *number* - Table of up to three activity IDs to register the group listing for.

**Description:**
For Classic, a player can register interest in a maximum of three activities at once. Other options for listings such as preferred item level, auto-accept, and private groups do not exist.