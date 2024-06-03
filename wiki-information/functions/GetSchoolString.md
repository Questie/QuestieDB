## Title: GetSchoolString

**Content:**
Returns the name of the specified damage school mask.
`school = GetSchoolString(schoolMask)`

**Parameters:**
- `schoolMask`
  - *number* - bitfield mask of damage types.

**Returns:**
- `school`
  - *string* - localized school name (e.g. "Frostfire"), or "Unknown" if the school combination isn't named.