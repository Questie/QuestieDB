## Event: INSPECT_READY

**Title:** INSPECT READY

**Content:**
Indicates inspect info is now ready.
`INSPECT_READY: inspecteeGUID`

**Payload:**
- `inspecteeGUID`
  - *string* - GUID of the unit being inspected.

**Content Details:**
Follows NotifyInspect() once details are asynchronously downloaded.