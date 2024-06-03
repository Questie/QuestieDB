## Title: C_PartyInfo.IsPartyFull

**Content:**
Needs summary.
`isFull = C_PartyInfo.IsPartyFull()`

**Parameters:**
- `category`
  - *number?* - If not provided, the active party is used.

**Returns:**
- `isFull`
  - *boolean*

**Example Usage:**
This function can be used to check if the current party is full. This is useful in scenarios where you want to ensure that there is space available before inviting another player to the party.

**Example:**
```lua
if not C_PartyInfo.IsPartyFull() then
    -- Invite a player to the party
    InviteUnit("PlayerName")
else
    print("The party is full.")
end
```

**Addons Usage:**
Large addons like "ElvUI" and "DBM" (Deadly Boss Mods) might use this function to manage party compositions and ensure that party-related features are only activated when the party is not full. For example, DBM might use it to check if there is room to invite more players for a raid.