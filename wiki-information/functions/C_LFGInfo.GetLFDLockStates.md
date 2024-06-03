## Title: C_LFGInfo.GetLFDLockStates

**Content:**
Needs summary.
`lockInfo = C_LFGInfo.GetLFDLockStates()`

**Returns:**
- `lockInfo`
  - *LFGLockInfo*
    - `Field`
    - `Type`
    - `Description`
    - `lfgID`
      - *number*
    - `reason`
      - *number* - index. See LFG_INSTANCE_INVALID_CODES
    - `hideEntry`
      - *boolean*

**Example Usage:**
This function can be used to retrieve the lockout states for various LFG (Looking For Group) instances. This is useful for determining which instances a player is locked out of and the reasons for the lockout.

**Addon Usage:**
Large addons like **DBM (Deadly Boss Mods)** and **ElvUI** might use this function to display lockout information to players, helping them manage their dungeon and raid lockouts more effectively.