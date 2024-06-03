## Title: GetNetStats

**Content:**
Returns bandwidth and latency network information.
`bandwidthIn, bandwidthOut, latencyHome, latencyWorld = GetNetStats()`

**Returns:**
- `bandwidthIn`
  - *number* - Current incoming bandwidth (download) usage, measured in KB/s.
- `bandwidthOut`
  - *number* - Current outgoing bandwidth (upload) usage, measured in KB/s.
- `latencyHome`
  - *number* - Average roundtrip latency to the home realm server (only updated every 30 seconds).
- `latencyWorld`
  - *number* - Average roundtrip latency to the current world server (only updated every 30 seconds).

**Description:**
Home/World latency (updated) - 4.0.6 | 2011-02-11 19:54 | Gelmkar

In essence, Home refers to your connection to your realm server. This connection sends chat data, auction house stuff, guild chat and info, some addon data, and various other data. It is a pretty slim connection in terms of bandwidth requirements.

World is a reference to the connection to our servers that transmits all the other data... combat, data from the people around you (specs, gear, enchants, etc.), NPCs, mobs, casting, professions, etc. Going into a highly populated zone (like a capital city) will drastically increase the amount of data being sent over this connection and will raise the reported latency.

Prior to 4.0.6, the in-game latency monitor only showed 'World' latency, which caused a lot of confusion for people who had no lag while chatting, but couldn't cast or interact with NPCs and ended up getting kicked offline. We hoped that including the latency meters for both connections would assist in clarifying this for everyone.

As is probably obvious based upon this information, the two connections are not used equally. There is a much larger amount of data being sent over the World connection, which is a good reason you may see disparities between the two times. If there is a large chunk of data 'queued' up on the server and waiting to be sent to your client, that 'ping' to the server is going to have to wait its turn in line, and the actual number returned will be much higher than the 'Home' connection.