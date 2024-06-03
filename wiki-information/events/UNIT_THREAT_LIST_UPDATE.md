## Event: UNIT_THREAT_LIST_UPDATE

**Title:** UNIT THREAT LIST UPDATE

**Content:**
Fired when the client receives updated threat information from the server, if an available mob's threat list has changed at all (i.e. anybody in combat with it has done anything).
`UNIT_THREAT_LIST_UPDATE: unitTarget`

**Payload:**
- `unitTarget`
  - *string* : UnitId

**Content Details:**
The unitTarget parameter may be "target" or "nameplateX" (and possibly some other units). However, this event does not fire for "targettarget" or "raidXtarget" (in WoW 1.13.6), even though updated threat values may be available using UnitDetailedThreatSituation. Therefore, threat addons for healers may need to periodically poll UnitDetailedThreatSituation, since enemies may be outside nameplate range (which is very short in Classic) and changing targets is undesired.