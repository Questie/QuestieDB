## Title: C_Club.GetAvatarIdList

**Content:**
Needs summary.
`avatarIds = C_Club.GetAvatarIdList(clubType)`

**Parameters:**
- `clubType`
  - *Enum.ClubType*
    - `Enum.ClubType`
      - `Value`
      - `Field`
      - `Description`
        - `0` - BattleNet
        - `1` - Character
        - `2` - Guild
        - `3` - Other

**Returns:**
- `avatarIds`
  - *number?*

**Description:**
Listen for `AVATAR_LIST_UPDATED` event. This can happen if we haven't downloaded the Battle.net avatar list yet.