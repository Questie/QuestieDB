## Title: C_GossipInfo.ForceGossip

**Content:**
Returns true if gossip text must be displayed. For example, making this return true shows the Banker gossip.
`forceGossip = C_GossipInfo.ForceGossip()`

**Returns:**
- `forceGossip`
  - *boolean*

**Description:**
When this is made to return true, gossip text will no longer be skipped if there is only one non-gossip option. For example, when speaking to the Banker.