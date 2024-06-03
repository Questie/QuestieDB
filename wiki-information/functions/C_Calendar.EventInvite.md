## Title: C_Calendar.EventInvite

**Content:**
Invites a player to the currently selected event.
`C_Calendar.EventInvite(name)`

**Parameters:**
- `name`
  - *string*

**Description:**
You can't do invites while another calendar action is pending.
Register to the event "CALENDAR_ACTION_PENDING" and using that, check with `C_Calendar.CanSendInvite` if you can invite.
Inviting a player who is already on the invitation list will result in a "<Player> has already been invited." dialog box appearing.