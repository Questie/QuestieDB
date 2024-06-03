## Title: C_Club.GetClubPrivileges

**Content:**
Needs summary.
`privilegeInfo = C_Club.GetClubPrivileges(clubId)`

**Parameters:**
- `clubId`
  - *string*

**Returns:**
- `privilegeInfo`
  - *structure* - ClubPrivilegeInfo
    - `Field`
    - `Type`
    - `Description`
    - `canDestroy`
      - *boolean*
    - `canSetAttribute`
      - *boolean*
    - `canSetName`
      - *boolean*
    - `canSetDescription`
      - *boolean*
    - `canSetAvatar`
      - *boolean*
    - `canSetBroadcast`
      - *boolean*
    - `canSetPrivacyLevel`
      - *boolean*
    - `canSetOwnMemberAttribute`
      - *boolean*
    - `canSetOtherMemberAttribute`
      - *boolean*
    - `canSetOwnMemberNote`
      - *boolean*
    - `canSetOtherMemberNote`
      - *boolean*
    - `canSetOwnVoiceState`
      - *boolean*
    - `canSetOwnPresenceLevel`
      - *boolean*
    - `canUseVoice`
      - *boolean*
    - `canVoiceMuteMemberForAll`
      - *boolean*
    - `canGetInvitation`
      - *boolean*
    - `canSendInvitation`
      - *boolean*
    - `canSendGuestInvitation`
      - *boolean*
    - `canRevokeOwnInvitation`
      - *boolean*
    - `canRevokeOtherInvitation`
      - *boolean*
    - `canGetBan`
      - *boolean*
    - `canGetSuggestion`
      - *boolean*
    - `canSuggestMember`
      - *boolean*
    - `canGetTicket`
      - *boolean*
    - `canCreateTicket`
      - *boolean*
    - `canDestroyTicket`
      - *boolean*
    - `canAddBan`
      - *boolean*
    - `canRemoveBan`
      - *boolean*
    - `canCreateStream`
      - *boolean*
    - `canDestroyStream`
      - *boolean*
    - `canSetStreamPosition`
      - *boolean*
    - `canSetStreamAttribute`
      - *boolean*
    - `canSetStreamName`
      - *boolean*
    - `canSetStreamSubject`
      - *boolean*
    - `canSetStreamAccess`
      - *boolean*
    - `canSetStreamVoiceLevel`
      - *boolean*
    - `canCreateMessage`
      - *boolean*
    - `canDestroyOwnMessage`
      - *boolean*
    - `canDestroyOtherMessage`
      - *boolean*
    - `canEditOwnMessage`
      - *boolean*
    - `canPinMessage`
      - *boolean*
    - `kickableRoleIds`
      - *number* - Roles that can be kicked and banned

**Description:**
The privileges for the logged-in user for this club.