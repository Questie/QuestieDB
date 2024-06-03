## Title: C_Club.SetSocialQueueingEnabled

**Content:**
Needs summary.
`C_Club.SetSocialQueueingEnabled(clubId, enabled)`

**Parameters:**
- `clubId`
  - *string*
- `enabled`
  - *boolean*

**Description:**
This function is used to enable or disable social queueing for a specific club. Social queueing allows club members to see each other's activities and join them more easily.

**Example Usage:**
```lua
-- Enable social queueing for a club with a specific ID
local clubId = "1234567890"
local enabled = true
C_Club.SetSocialQueueingEnabled(clubId, enabled)
```

**Addons:**
Large addons like "ElvUI" and "WeakAuras" might use this function to manage social interactions and queueing within their custom interfaces, enhancing the social experience for users.