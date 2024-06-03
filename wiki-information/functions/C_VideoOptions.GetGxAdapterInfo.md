## Title: C_VideoOptions.GetGxAdapterInfo

**Content:**
Returns info about the system's graphics adapter.
`adapters = C_VideoOptions.GetGxAdapterInfo()`

**Returns:**
- `adapters`
  - *structure* - GxAdapterInfoDetails
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string* - e.g. "NVIDIA GeForce GTX 1060GB"
    - `isLowPower`
      - *boolean*
    - `isExternal`
      - *boolean* - whether the adapter is external