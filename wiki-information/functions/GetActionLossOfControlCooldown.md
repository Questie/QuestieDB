## Title: GetActionLossOfControlCooldown

**Content:**
Returns information about a loss-of-control cooldown affecting an action.
`start, duration = GetActionLossOfControlCooldown(slot)`

**Parameters:**
- `slot`
  - *number* - action slot to query information about.

**Returns:**
- `start`
  - *number* - time at which the cooldown began, per GetTime.
- `duration`
  - *number* - duration of the cooldown in seconds; 0 if the action is not currently affected by a loss-of-control cooldown.

**Reference:**
- `Cooldown:SetLossOfControlCooldown`
- `C_LossOfControl.GetEventInfo`
- `LOSS_OF_CONTROL_UPDATE`