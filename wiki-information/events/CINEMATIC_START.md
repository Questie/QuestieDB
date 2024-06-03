## Event: CINEMATIC_START

**Title:** CINEMATIC START

**Content:**
Fires for an in-game cinematic/cutscene.
`CINEMATIC_START: canBeCancelled`

**Payload:**
- `canBeCancelled`
  - *boolean* - This unintuitively indicates whether it's a "real" cinematic, otherwise it's a vehicle cinematic which requires canceling in a different way.

**Related Information:**
CINEMATIC_STOP
InCinematic(), IsInCinematicScene()