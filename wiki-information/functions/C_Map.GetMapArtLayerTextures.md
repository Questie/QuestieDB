## Title: C_Map.GetMapArtLayerTextures

**Content:**
Returns the art layer textures for a map.
`textures = C_Map.GetMapArtLayerTextures(uiMapID, layerIndex)`

**Parameters:**
- `uiMapID`
  - *number* - UiMapID
- `layerIndex`
  - *number*

**Returns:**
- `textures`
  - *number*

**Description:**
This function is used to retrieve the textures for a specific art layer of a map. It can be useful for addons that need to display or manipulate map textures.

**Example Usage:**
```lua
local uiMapID = 1415 -- Example map ID
local layerIndex = 1 -- Example layer index
local textures = C_Map.GetMapArtLayerTextures(uiMapID, layerIndex)
for i, texture in ipairs(textures) do
    print("Texture " .. i .. ": " .. texture)
end
```

**Addons Using This Function:**
- **Mapster**: An addon that enhances the World Map. It uses this function to retrieve and display custom map textures.
- **HandyNotes**: An addon that adds custom notes to the world map. It may use this function to overlay additional textures on the map.