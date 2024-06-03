## Event: ENTITLEMENT_DELIVERED

**Title:** ENTITLEMENT DELIVERED

**Content:**
Needs summary.
`ENTITLEMENT_DELIVERED: entitlementType, textureID, name, payloadID, showFancyToast`

**Payload:**
- `entitlementType`
  - *number* - Enum.WoWEntitlementType
- `textureID`
  - *number*
- `name`
  - *string*
- `payloadID`
  - *number?*
- `showFancyToast`
  - *boolean*
  
  Enum.WoWEntitlementType
  | Value | Field       | Description  |
  |-------|-------------|--------------|
  | 0     | Item        |              |
  | 1     | Mount       |              |
  | 2     | Battlepet   |              |
  | 3     | Toy         |              |
  | 4     | Appearance  |              |
  | 5     | AppearanceSet|             |
  | 6     | GameTime    |              |
  | 7     | Title       |              |
  | 8     | Illusion    |              |
  | 9     | Invalid     |              |