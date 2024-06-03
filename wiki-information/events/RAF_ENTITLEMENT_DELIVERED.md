## Event: RAF_ENTITLEMENT_DELIVERED

**Title:** RAF ENTITLEMENT DELIVERED

**Content:**
Needs summary.
`RAF_ENTITLEMENT_DELIVERED: entitlementType, textureID, name, payloadID, showFancyToast, rafVersion`

**Payload:**
- `entitlementType`
  - *Enum.WoWEntitlementType* - 
    - Value
    - Field
    - Description
    - 0 - Item
    - 1 - Mount
    - 2 - Battlepet
    - 3 - Toy
    - 4 - Appearance
    - 5 - AppearanceSet
    - 6 - GameTime
    - 7 - Title
    - 8 - Illusion
    - 9 - Invalid
- `textureID`
  - *number*
- `name`
  - *string*
- `payloadID`
  - *number?*
- `showFancyToast`
  - *boolean*
- `rafVersion`
  - *Enum.RecruitAFriendRewardsVersion* - 
    - Value
    - Field
    - Description
    - 0 - InvalidVersion
    - 1 - UnusedVersionOne
    - 2 - VersionTwo
    - 3 - VersionThree