## Event: PLAYER_FLAGS_CHANGED

**Title:** PLAYER FLAGS CHANGED

**Content:**
This event fires when a Unit's flags change (e.g. /afk, /dnd).
`PLAYER_FLAGS_CHANGED: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId

**Content Details:**
WoW condenses simultaneous flag changes into a single event. If you are currently AFK and not(DND) but you type /dnd you'll see two Chat Log messages ("You are no longer AFK" and "You are now DND: Do Not Disturb") but you'll only see a single PLAYER_FLAGS_CHANGED event.