## Event: STREAMING_ICON

**Title:** STREAMING ICON

**Content:**
Fires when the streaming client state is updated.
`STREAMING_ICON: streamingStatus`

**Payload:**
- `streamingStatus`
  - *number*
    - 0 - Nothing is currently being downloaded.
    - 1 - Game data is currently being downloaded (green)
    - 2 - Important game data is currently being downloaded (yellow)
    - 3 - Core game data is currently being downloaded (red)