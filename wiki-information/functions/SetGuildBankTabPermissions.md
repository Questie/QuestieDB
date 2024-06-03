## Title: SetGuildBankTabPermissions

**Content:**
Modifies the permissions for a guild bank tab.
`SetGuildBankTabPermissions(tab, index, enabled)`

**Parameters:**
- `tab`
  - *number* - Bank Tab to edit.
- `index`
  - *number* - Index of Permission to edit.
- `enabled`
  - *boolean* - true or false to Enable or Disable permission.

**Description:**
Use `GuildControlSetRank()` to set what rank you are editing permissions for. Will not save until `GuildControlSaveRank()` is called.

Current Known Index Values:
- 1 = View Tab
- 2 = Deposit Item