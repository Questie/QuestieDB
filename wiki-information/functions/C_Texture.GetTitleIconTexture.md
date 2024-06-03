## Title: C_Texture.GetTitleIconTexture

**Content:**
Needs summary.
`C_Texture.GetTitleIconTexture(titleID, version, callback)`

**Parameters:**
- `titleID`
  - *string*
- `version`
  - *Enum.TitleIconVersion*
    - `Value`
    - `Field`
    - `Description`
    - `0`
      - Small
    - `1`
      - Medium
    - `2`
      - Large
- `callback`
  - *function : GetTitleIconTextureCallback*
    - `Param`
    - `Type`
    - `Description`
    - `1`
      - success
      - *boolean*
    - `2`
      - texture
      - *number : fileID*