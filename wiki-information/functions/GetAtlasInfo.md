## Title: C_Texture.GetAtlasInfo

**Content:**
Returns atlas info.
`info = C_Texture.GetAtlasInfo(atlas)`

**Parameters:**
- `atlas`
  - *string* - Name of the atlas

**Returns:**
- `info`
  - *AtlasInfo*
    - `Field`
    - `Type`
    - `Description`
    - `width`
      - *number*
    - `height`
      - *number*
    - `rawSize`
      - *vector2*
    - `leftTexCoord`
      - *number*
    - `rightTexCoord`
      - *number*
    - `topTexCoord`
      - *number*
    - `bottomTexCoord`
      - *number*
    - `tilesHorizontally`
      - *boolean*
    - `tilesVertically`
      - *boolean*
    - `file`
      - *number?* - FileID of parent texture
    - `filename`
      - *string?*
    - `sliceData`
      - *UITextureSliceData?*
        - `UITextureSliceData`
          - `Field`
          - `Type`
          - `Description`
          - `marginLeft`
            - *number*
          - `marginTop`
            - *number*
          - `marginRight`
            - *number*
          - `marginBottom`
            - *number*
          - `sliceMode`
            - *Enum.UITextureSliceMode*
              - `Enum.UITextureSliceMode`
                - `Value`
                - `Field`
                - `Description`
                - `0`
                  - Stretched
                  - Default
                - `1`
                  - Tiled

**Reference:**
- `Texture:GetAtlas()`
- `Texture:SetAtlas()`
- `UI CreateAtlasMarkup` - Returns an inline fontstring texture from an atlas
- `Helix/AtlasInfo.lua` - Lua table containing atlas info
- `UiTextureAtlasMember.db2` - DBC for atlases
- `Texture Atlas Viewer` - Addon for browsing atlases in-game