## Title: C_AccountInfo.IsGUIDRelatedToLocalAccount

**Content:**
Returns whether a GUID is related to the local (self) account.
`isLocalUser = C_AccountInfo.IsGUIDRelatedToLocalAccount(guid)`

**Parameters:**
- `guid`
  - *string* : WOWGUID

**Returns:**
- `isLocalUser`
  - *boolean*

**Example Usage:**
This function can be used to determine if a specific GUID (Globally Unique Identifier) belongs to the player’s own account. This can be useful in scenarios where you need to check if a certain action or event is related to the player.

**Example:**
```lua
local guid = UnitGUID("player")
local isLocalUser = C_AccountInfo.IsGUIDRelatedToLocalAccount(guid)
if isLocalUser then
    print("This GUID belongs to the local player.")
else
    print("This GUID does not belong to the local player.")
end
```

**Addons Usage:**
Large addons like **WeakAuras** and **ElvUI** might use this function to personalize user experiences or to ensure certain functionalities are only applied to the local player. For instance, WeakAuras could use it to display specific auras or effects only for the player’s character.