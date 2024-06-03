## Event: TAXIMAP_OPENED

**Title:** TAXIMAP OPENED

**Content:**
Fired when the taxi viewer is opened.
`TAXIMAP_OPENED: system`

**Payload:**
- `system`
  - *Enum.UIMapSystem*
  - *Value*
  - *Field*
  - *Description*
  - 0 - World
  - 1 - Taxi
  - 2 - Adventure
  - 3 - Minimap

**Content Details:**
This will fire even if you know no flight paths connected to the one you're at, so the map doesn't actually open.