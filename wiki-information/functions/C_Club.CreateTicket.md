## Title: C_Club.CreateTicket

**Content:**
This is protected and only available to the Blizzard UI. Used for creating a ticket for a community club.
`C_Club.CreateTicket(clubId)`

**Parameters:**
- `clubId`
  - *string*
- `allowedRedeemCount`
  - *number?* - Number of uses. `nil` means unlimited
- `duration`
  - *number?* - Duration in seconds. `nil` never expires
- `defaultStreamId`
  - *string?*
- `isCrossFaction`
  - *boolean?*

**Description:**
Check `canCreateTicket` privilege.