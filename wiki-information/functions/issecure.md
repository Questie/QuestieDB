## Title: issecure

**Content:**
Returns true if the current execution path is secure.
`secure = issecure()`

**Returns:**
- `secure`
  - *boolean* - true if the current path is secure (and able to call protected functions), false otherwise.

**Description:**
This function will return false if called from any (insecure) addon code.
Certain API functions (and FrameXML functions that check this function's return value) cannot be called from tainted execution paths.