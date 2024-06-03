## Title: GetGuildBankTabPermissions

**Content:**
Gets display / player's access info. Limited data available without bank proximity.
`canView, canDeposit, canEdit, stacksPerDay = GetGuildBankTabPermissions(tab)`

**Parameters:**
- `tab`
  - *number* - guild bank tab number

**Returns:**
- `canView`
  - *boolean* - 1 if the selected rank can view this guild bank tab, nil otherwise.
- `canDeposit`
  - *boolean* - 1 if the selected rank can deposit to this guild bank tab, nil otherwise.
- `canEdit`
  - *boolean* - 1 if the selected rank can edit the bank tab text, nil otherwise.
- `stacksPerDay`
  - *number* - Amount of withdrawable stacks per day or 0 if none.

**Usage:**
```lua
local canView, canDeposit, canEdit, stacksPerDay = GetGuildBankTabPermissions(1);
if canDeposit then
  DEFAULT_CHAT_FRAME:AddMessage("Can view, deposit and retrieve " .. stacksPerDay .. " stacks a day on tab 1.");
elseif canView then
  DEFAULT_CHAT_FRAME:AddMessage("Can view and retrieve " .. stacksPerDay .. " stacks a day on tab 1.");
else
  DEFAULT_CHAT_FRAME:AddMessage("Can not view tab 1.");
end
```

**Miscellaneous:**
- **Result:**
  - If you are the guild master, this will return data for the rank you currently have selected in guild control. Else, it will return data for your own rank.
  - Guild masters can always view, deposit and withdraw without limits; this function does not properly return that. Use `IsGuildLeader()` if you want to know if this is the case.
  - Note that being able to deposit implies being able to view.