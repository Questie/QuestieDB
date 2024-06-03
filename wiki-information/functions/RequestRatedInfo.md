## Title: RequestRatedInfo

**Content:**
Requests information about the player's rated PvP stats from the server.
`RequestRatedInfo()`

**Description:**
Triggers `PVP_RATED_STATS_UPDATE` when the client receives a reply from the server.
FrameXML (counterintuitively) uses the event to update player's PvP currencies and random/holiday battleground rewards.