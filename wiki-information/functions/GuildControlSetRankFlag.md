## Title: GuildControlSetRankFlag

**Content:**
Sets guild rank permissions.
`GuildControlSetRankFlag(index, enabled)`

**Parameters:**
- `index`
  - *number* - the flag index, between 1 and GuildControlGetNumRanks().
- `enabled`
  - *boolean* - whether the flag is enabled or disabled.

**Description:**
Calling this API changes the value of the current rank flags. These changes are not saved until a call to `GuildControlSaveRank()` is made.

**Flag indices:**
- **GUILDCONTROL_OPTION**
  - **Index**
  - **GlobalString**
  - **Name**
  - **Description**
  - `1`
    - `GUILDCONTROL_OPTION1`
    - Guildchat Listen
  - `2`
    - `GUILDCONTROL_OPTION2`
    - Guildchat Speak
  - `3`
    - `GUILDCONTROL_OPTION3`
    - Officerchat Listen
  - `4`
    - `GUILDCONTROL_OPTION4`
    - Officerchat Speak
  - `5`
    - `GUILDCONTROL_OPTION5`
    - Promote
  - `6`
    - `GUILDCONTROL_OPTION6`
    - Demote
  - `7`
    - `GUILDCONTROL_OPTION7`
    - Invite Member
  - `8`
    - `GUILDCONTROL_OPTION8`
    - Remove Member
  - `9`
    - `GUILDCONTROL_OPTION9`
    - Set MOTD
  - `10`
    - `GUILDCONTROL_OPTION10`
    - Edit Public Note
  - `11`
    - `GUILDCONTROL_OPTION11`
    - View Officer Note
  - `12`
    - `GUILDCONTROL_OPTION12`
    - Edit Officer Note
  - `13`
    - `GUILDCONTROL_OPTION13`
    - Modify Guild Info
  - `14`
    - `GUILDCONTROL_OPTION14`
    - Create Guild Event
  - `15`
    - `GUILDCONTROL_OPTION15`
    - Guild Bank Repair
    - Use guild funds for repairs
  - `16`
    - `GUILDCONTROL_OPTION16`
    - Withdraw Gold
    - Withdraw gold from the guild bank
  - `17`
    - `GUILDCONTROL_OPTION17`
    - Create Guild Event
  - `18`
    - `GUILDCONTROL_OPTION18`
    - Requires Authenticator
  - `19`
    - `GUILDCONTROL_OPTION19`
    - Modify Bank Tabs
  - `20`
    - `GUILDCONTROL_OPTION20`
    - Remove Guild Event
  - `21`
    - `GUILDCONTROL_OPTION21`
    - Recruitment