## Title: GetGuildBankTabInfo

**Content:**
Returns info for a guild bank tab.
`name, icon, isViewable, canDeposit, numWithdrawals, remainingWithdrawals, filtered = GetGuildBankTabInfo(tab)`

**Parameters:**
- `tab`
  - *number* - The index of the guild bank tab. (result of `GetCurrentGuildBankTab()`)

**Returns:**
- `name`
  - *string* - Title of the bank tab.
- `icon`
  - *string* - Path to the bank tab icon texture.
- `isViewable`
  - *boolean* - True if the player can click on the bank tab.
- `canDeposit`
  - *boolean* - True if the player can deposit items.
- `numWithdrawals`
  - *number* - Available withdrawals per day.
- `remainingWithdrawals`
  - *number* - Remaining withdrawals for the day.
- `filtered`
  - *boolean* - True if the requested tab is filtered out.

**Description:**
As of 4.0.3, the `remainingWithdrawals` value seems to be bugged, in that it returns the value for the currently selected tab rather than the tab passed to the function. This bug can be demonstrated by entering `/dump GetGuildBankTabInfo(1)` while viewing different tabs of the bank; the value returned reflects the currently viewed tab, rather than the first tab. You can get around this by calling `QueryGuildBankTab(tabNum)` before calling this function.