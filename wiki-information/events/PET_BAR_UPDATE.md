## Event: PET_BAR_UPDATE

**Title:** PET BAR UPDATE

**Content:**
Fired whenever the pet bar is updated and its GUI needs to be re-rendered/refreshed.
`PET_BAR_UPDATE`

**Payload:**
- `None`

**Content Details:**
Examples of actions which trigger this event:
- Losing your pet (causes the pet bar to vanish).
- Gaining a pet (causes the pet bar to appear).
- Triggering the pet "aggressive/defensive/passive" state (whether via the button or via commands like "/petdefensive"). Triggers even if the new state is the same as last time (ie. by re-triggering the same button multiple times in a row).
- Triggering the pet "follow" or "stay" commands (but not the "attack" command since unlike the others, its button never gets highlighted on the bar while the pet is attacking). Just like the aggressiveness state, this also reacts via commands like "/petstay", and will likewise react to repeated re-triggering (through any method).
- Toggling pet skill "autocast" state, regardless of whether you do it via the spellbook, or right-clicking on the bar icon itself, or using commands like "/petautocasttoggle Growl".
- Moving icons on the pet skill bar, such as by dragging icons from the pet spellbook onto the pet bar. (This is not your regular player action bar, which of course can't even contain pet spells even if you attempt to drag them there manually.)