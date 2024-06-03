## Event: DYNAMIC_GOSSIP_POI_UPDATED

**Title:** DYNAMIC GOSSIP POI UPDATED

**Content:**
Fired after asking guards in major cities for directions to a point of interest, causing the small red flag to be positioned on the world map and minimap (or to disappear when no longer needed).
`DYNAMIC_GOSSIP_POI_UPDATED`

**Payload:**
- `None`

**Content Details:**
Maps do not normally need to track this event if they have already acquired the GossipDataProvider or an equivalent
Custom replacements for GossipDataProvider could use this event to trigger RefreshAllData()

**Related Information:**
- GossipDataProvider.lua where this event is used to update the world map, archived at townlong-yak.
- C_GossipInfo.GetGossipPoiForUiMapID - provides a pointer that may be passed to GetGossipPoiInfo() for a given uiMapID
- C_GossipInfo.GetGossipPoiInfo - provides information about where a given gossip pin (usually a red flag) should appear on the given uiMapID