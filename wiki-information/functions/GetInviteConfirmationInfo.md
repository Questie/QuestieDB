## Title: GetInviteConfirmationInfo

**Content:**
Retrieves information about a player that could be invited.
`confirmationType, name, guid, rolesInvalid, willConvertToRaid, level, spec, itemLevel = GetInviteConfirmationInfo(invite)`

**Parameters:**
- `invite`
  - *unknown* - return value of function `GetNextPendingInviteConfirmation`

**Returns:**
- `confirmationType`
  - *number* - Integer value related to constants like `LE_INVITE_CONFIRMATION_REQUEST`
- `name`
  - *string* - name of the player
- `guid`
  - *string* - a string containing the hexadecimal representation of the player's GUID. Player-- (Example: "Player-976-0002FD64")
- `rolesInvalid`
  - *boolean* - The player has no valid roles.
- `willConvertToRaid`
  - *boolean* - Inviting this player or group will convert your party to a raid.
- `level`
  - *number* - player level
- `spec`
  - *number* - player specialization id. The player specialization name can be requested by `GetSpecializationInfoByID`.
- `itemLevel`
  - *number* - player item level

**Reference:**
- `GetNextPendingInviteConfirmation`

**Related Constants:**
- `LE_INVITE_CONFIRMATION_QUEUE_WARNING = 3`
- `LE_INVITE_CONFIRMATION_RELATION_NONE = 0`
- `LE_INVITE_CONFIRMATION_RELATION_FRIEND = 1`
- `LE_INVITE_CONFIRMATION_RELATION_GUILD = 2`
- `LE_INVITE_CONFIRMATION_REQUEST = 1`
- `LE_INVITE_CONFIRMATION_SUGGEST = 2`