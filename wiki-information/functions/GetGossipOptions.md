## Title: GetGossipOptions

**Content:**
Get the available gossip items on an NPC (possibly stuff like the BWL and MC orbs too).
`title1, gossip1, ... = GetGossipOptions()`

**Returns:**
- `title`
  - *string* - The title of the gossip item.
- `gossip`
  - *string* - The gossip type: banker, battlemaster, binder, gossip, healer, petition, tabard, taxi, trainer, unlearn, vendor, workorder

**Description:**
The gossip options are available after `GOSSIP_SHOW` has fired.