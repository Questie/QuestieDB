## Event: CLUB_ERROR

**Title:** CLUB ERROR

**Content:**
Needs summary.
`CLUB_ERROR: action, error, clubType`

**Payload:**
- `action`
  - *number* - Enum.ClubActionType
- `error`
  - *number* - Enum.ClubErrorType
- `clubType`
  - *number* - Enum.ClubType
  - *Enum.ClubActionType*
    - Value
    - Field
    - Description
    - 0
      - ErrorClubActionSubscribe
    - 1
      - ErrorClubActionCreate
    - 2
      - ErrorClubActionEdit
    - 3
      - ErrorClubActionDestroy
    - 4
      - ErrorClubActionLeave
    - 5
      - ErrorClubActionCreateTicket
    - 6
      - ErrorClubActionDestroyTicket
    - 7
      - ErrorClubActionRedeemTicket
    - 8
      - ErrorClubActionGetTicket
    - 9
      - ErrorClubActionGetTickets
    - 10
      - ErrorClubActionGetBans
    - 11
      - ErrorClubActionGetInvitations
    - 12
      - ErrorClubActionRevokeInvitation
    - 13
      - ErrorClubActionAcceptInvitation
    - 14
      - ErrorClubActionDeclineInvitation
    - 15
      - ErrorClubActionCreateStream
    - 16
      - ErrorClubActionEditStream
    - 17
      - ErrorClubActionDestroyStream
    - 18
      - ErrorClubActionInviteMember
    - 19
      - ErrorClubActionEditMember
    - 20
      - ErrorClubActionEditMemberNote
    - 21
      - ErrorClubActionKickMember
    - 22
      - ErrorClubActionAddBan
    - 23
      - ErrorClubActionRemoveBan
    - 24
      - ErrorClubActionCreateMessage
    - 25
      - ErrorClubActionEditMessage
    - 26
      - ErrorClubActionDestroyMessage
  - *Enum.ClubErrorType*
    - Value
    - Field
    - Description
    - 0
      - ErrorCommunitiesNone
    - 1
      - ErrorCommunitiesUnknown
    - 2
      - ErrorCommunitiesNeutralFaction
    - 3
      - ErrorCommunitiesUnknownRealm
    - ...
  - *Enum.ClubType*
    - Value
    - Field
    - Description
    - 0
      - BattleNet
    - 1
      - Character
    - 2
      - Guild
    - 3
      - Other