## Event: QUEST_SESSION_NOTIFICATION

**Title:** QUEST SESSION NOTIFICATION

**Content:**
Fires with a Party Sync notification.
`QUEST_SESSION_NOTIFICATION: result, guid`

**Payload:**
- `result`
  - *Enum.QuestSessionResult*
- `guid`
  - *string* - The player triggering the notification.
  - *Enum.QuestSessionResult*
    - **Value**
    - **Type**
    - **Description**
    - 0
      - Ok
      - No notification message.
    - 1
      - NotInParty
      - "You are not in a party."
    - 2
      - InvalidOwner
      - "%s cannot participate in Party Sync."
    - 3
      - AlreadyActive
      - "Party sync is already active."
    - 4
      - NotActive
      - "Party Sync is not active."
    - 5
      - InRaid
      - "You are in a raid."
    - 6
      - OwnerRefused
      - "%s declined the Party Sync request."
    - 7
      - Timeout
      - "The Party Sync request timed out."
    - 8
      - Disabled
      - "Party Sync is currently disabled."
    - 9
      - Started
      - "Party Sync activated."
    - 10
      - Stopped
      - "Party Sync ended."
    - 11
      - Joined
      - No notification message.
    - 12
      - Left
      - "You left the Party Sync."
    - 13
      - OwnerLeft
      - "Party Sync ended."
    - 14
      - ReadyCheckFailed
      - "A party member declined the Party Sync request."
    - 15
      - PartyDestroyed
      - "Party Sync ended."
    - 16
      - MemberTimeout
      - No notification message.
    - 17
      - AlreadyMember
      - "You are already in Party Sync."
    - 18
      - NotOwner
      - "You are not the owner of the Party Sync."
    - 19
      - AlreadyOwner
      - "You are already in Party Sync.
    - 20
      - AlreadyJoined
      - "You are already in Party Sync."
    - 21
      - NotMember
      - "You are already in Party Sync."
    - 22
      - Busy
      - "Party Sync is busy."
    - 23
      - JoinRejected
      - "Your request to join the Party Sync was denied."
    - 24
      - Logout
      - No notification message.
    - 25
      - Empty
      - No notification message.
    - 26
      - QuestNotCompleted
      - "Party Sync failed to start because a party member has not completed their starting quests."
    - 27
      - Resync
      - "Quests have been re-synced."
    - 28
      - Restricted
      - "Party Sync failed to start because a party member is on a Class Trial."
    - 29
      - InPetBattle
      - "Party Sync failed to start because a party member is in a pet battle."
    - 30
      - InvalidPublicParty
      - "An unknown error has occurred while attempting to activate Party Sync."
    - 31
      - Unknown
      - "An unknown error has occurred while attempting to activate Party Sync."
    - 32
      - InCombat
      - "You cannot start Party Sync because you are in combat."
    - 33
      - MemberInCombat
      - "You cannot join a Party Sync if a member of the party is in combat."

**Patch Updates:**
Patch 9.0.5 (2021-03-09): Added MemberInCombat field. 
Patch 9.0.1 (2020-10-13): Added InCombat field. 
Patch 8.2.5 (2019-09-24): Added.