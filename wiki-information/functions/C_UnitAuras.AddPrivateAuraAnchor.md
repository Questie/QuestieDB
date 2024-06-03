## Title: C_UnitAuras.AddPrivateAuraAnchor

**Content:**
Needs summary.
`anchorID = C_UnitAuras.AddPrivateAuraAnchor(args)`

**Parameters:**
- `args`
  - *AddPrivateAuraAnchorArgs*
    - `Field`
    - `Type`
    - `Description`
    - `unitToken`
      - *string*
    - `auraIndex`
      - *number*
    - `parent`
      - *Frame*
    - `showCountdownFrame`
      - *boolean*
    - `showCountdownNumbers`
      - *boolean*
    - `iconInfo`
      - *PrivateAuraIconInfo?*
    - `durationAnchor`
      - *AnchorBinding?*

**PrivateAuraIconInfo**
- `Field`
- `Type`
- `Description`
- `iconAnchor`
  - *AnchorBinding*
- `iconWidth`
  - *number : uiUnit*
- `iconHeight`
  - *number : uiUnit*

**AnchorBinding**
- `Field`
- `Type`
- `Description`
- `point`
  - *string : FramePoint*
    - TOPLEFT, TOPRIGHT, BOTTOMLEFT, BOTTOMRIGHT, TOP, BOTTOM, LEFT, RIGHT, CENTER
- `relativeTo`
  - *ScriptRegion*
- `relativePoint`
  - *string : FramePoint*
    - TOPLEFT, TOPRIGHT, BOTTOMLEFT, BOTTOMRIGHT, TOP, BOTTOM, LEFT, RIGHT, CENTER
- `offsetX`
  - *number : uiUnit*
- `offsetY`
  - *number : uiUnit*

**Returns:**
- `anchorID`
  - *number?*