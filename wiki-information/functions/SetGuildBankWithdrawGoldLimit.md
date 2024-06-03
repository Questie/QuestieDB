## Title: SetGuildBankWithdrawGoldLimit

**Content:**
Sets the gold withdraw limit for the guild bank.
`SetGuildBankWithdrawGoldLimit(amount)`

**Parameters:**
- `amount`
  - *number* - the amount of gold to withdraw per day

**Description:**
Sets the value of the Gold Withdrawal field for the current rank (used for repairs and direct withdrawals). These changes are not saved until a call to `GuildControlSaveRank()` is made. In order to actually withdraw or use guild repairs, the flags for those actions must be set using `GuildControlSetRankFlag()`.