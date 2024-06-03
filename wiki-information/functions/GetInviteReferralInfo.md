## Title: C_PartyInfo.GetInviteReferralInfo

**Content:**
Returns info for Quick join invites.
`outReferredByGuid, outReferredByName, outRelationType, outIsQuickJoin, outClubId = C_PartyInfo.GetInviteReferralInfo(inviteGUID)`

**Parameters:**
- `inviteGUID`
  - *string*

**Returns:**
- `outReferredByGuid`
  - *string*
- `outReferredByName`
  - *string*
- `outRelationType`
  - *Enum.PartyRequestJoinRelation*
- `outIsQuickJoin`
  - *boolean*
- `outClubId`
  - *string*

**Enum.PartyRequestJoinRelation:**
- `Value`
- `Field`
- `Description`
  - `0`
    - `None`
  - `1`
    - `Friend`
  - `2`
    - `Guild`
  - `3`
    - `Club`
  - `4`
    - `NumPartyRequestJoinRelations`