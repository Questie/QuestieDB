## Event: ACTIONBAR_SLOT_CHANGED

**Title:** ACTIONBAR SLOT CHANGED

**Content:**
Fired when any actionbar slot's contents change; typically the picking up and dropping of buttons.
`ACTIONBAR_SLOT_CHANGED: slot`

**Payload:**
- `slot`
  - *number*

**Content Details:**
On 4/24/2006, Slouken stated "ACTIONBAR_SLOT_CHANGED is also sent whenever something changes whether or not the button should be dimmed. The first argument is the slot which changed." This means actions that affect the internal fields of action bar buttons also generate this event for the affected button(s). Examples include the Start and End of casting channeled spells, casting a new buff on yourself, and the cancellation or expiration of a buff on yourself.