## Title: C_GamePad.SetConfig

**Content:**
Needs summary.
`C_GamePad.SetConfig(config)`

**Parameters:**
- `config`
  - *GamePadConfig*
    - `Field`
    - `Type`
    - `Description`
    - `comment`
      - *string?*
    - `name`
      - *string?*
    - `configID`
      - *GamePadConfigID*
    - `labelStyle`
      - *string?*
    - `rawButtonMappings`
      - *GamePadRawButtonMapping*
    - `rawAxisMappings`
      - *GamePadRawAxisMapping*
    - `axisConfigs`
      - *GamePadAxisConfig*
    - `stickConfigs`
      - *GamePadStickConfig*

**GamePadConfigID:**
- `Field`
- `Type`
- `Description`
- `vendorID`
  - *number?*
- `productID`
  - *number?*

**GamePadRawButtonMapping:**
- `Field`
- `Type`
- `Description`
- `rawIndex`
  - *number*
- `button`
  - *string?*
- `axis`
  - *string?*
- `axisValue`
  - *number?*
- `comment`
  - *string?*

**GamePadRawAxisMapping:**
- `Field`
- `Type`
- `Description`
- `rawIndex`
  - *number*
- `axis`
  - *string?*
- `comment`
  - *string?*

**GamePadAxisConfig:**
- `Field`
- `Type`
- `Description`
- `axis`
  - *string*
- `shift`
  - *number?*
- `scale`
  - *number?*
- `deadzone`
  - *number?*
- `buttonThreshold`
  - *number?*
- `buttonPos`
  - *string?*
- `buttonNeg`
  - *string?*
- `comment`
  - *string?*

**GamePadStickConfig:**
- `Field`
- `Type`
- `Description`
- `stick`
  - *string*
- `axisX`
  - *string?*
- `axisY`
  - *string?*
- `deadzone`
  - *number?*
- `deadzoneX`
  - *number?* (Added in 9.1.5)
- `deadzoneY`
  - *number?* (Added in 9.1.5)
- `comment`
  - *string?*