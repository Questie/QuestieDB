## Title: GetTotemTimeLeft

**Content:**
Returns active time remaining (in seconds) before a totem (or ghoul) disappears.
`seconds = GetTotemTimeLeft(slot)`

**Parameters:**
- `slot`
  - *number* - Which totem to query:
    - 1 - Fire (or Death Knight's ghoul)
    - 2 - Earth
    - 3 - Water
    - 4 - Air

**Returns:**
- `seconds`
  - *number* - Time remaining before the totem/ghoul is automatically destroyed

**Description:**
Totem functions are also used for ghouls summoned by a Death Knight (if the ghoul is not made a controllable pet by Raise Dead rank 2).

**Reference:**
- `GetTime`
- `GetTotemInfo`