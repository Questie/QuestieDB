## Event: UPDATE_MOUSEOVER_UNIT

**Title:** UPDATE MOUSEOVER UNIT

**Content:**
Fired when the mouseover object needs to be updated.
`UPDATE_MOUSEOVER_UNIT`

**Payload:**
- `None`

**Content Details:**
Fired when the target of the "mouseover" UnitId has changed and is a 3d model. (Does not fire when UnitExists("mouseover") becomes nil, or if you mouse over a unitframe.)
This appears to have been changed at some point, it now fires when mousing over unit frames as well.