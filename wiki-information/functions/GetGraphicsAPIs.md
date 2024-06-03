## Title: GetGraphicsAPIs

**Content:**
Returns the supported graphics APIs for the system, D3D11_LEGACY, D3D11, D3D12, etc.
`cvarValues, ... = GetGraphicsAPIs()`

**Returns:**
- (variable returns: `cvarValue1`, `cvarValue2`, ...)
  - `cvarValues`
    - *string* - a value for CVar `gxApi`.
      - `Value`
      - `Description`
      - `D3D11_LEGACY`
        - Old single-threaded rendering backend using DirectX 11
      - `D3D11`
        - New multi-threaded rendering backend using DirectX 11
      - `D3D12`
        - Multi-threaded rendering backend using DirectX 12
      - `metal`
      - `gll`
      - `opengl`

**Reference:**
Kaivax 2019-03-12. New Graphics APIs in 8.1.5.