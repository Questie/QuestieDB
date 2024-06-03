## Title: GetPetitionInfo

**Content:**
Returns info for the petition being viewed.
`petitionType, title, bodyText, maxSigs, originator, isOriginator, minSigs = GetPetitionInfo()`

**Returns:**
- `petitionType`
  - *string* - The type of petition (e.g., "guild" or "arena")
- `title`
  - *string* - The title of the group being created
- `bodyText`
  - *string* - The body text of the petition
- `maxSigs`
  - *number* - The maximum number of signatures allowed on the petition
- `originator`
  - *string* - The name of the person who started the petition
- `isOriginator`
  - *boolean* - Whether the player is the originator of the petition
- `minSigs`
  - *number* - The minimum number of signatures required for the petition

**Reference:**
- `PETITION_SHOW` - Indicates information is available.