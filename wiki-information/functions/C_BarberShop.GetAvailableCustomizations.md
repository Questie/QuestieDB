## Title: C_BarberShop.GetAvailableCustomizations

**Content:**
Needs summary.
`categories = C_BarberShop.GetAvailableCustomizations()`

**Returns:**
- `categories`
  - *CharCustomizationCategory*
    - `Field`
    - `Type`
    - `Description`
    - `id`
      - *number*
    - `orderIndex`
      - *number*
    - `name`
      - *string*
    - `icon`
      - *string : textureAtlas*
    - `selectedIcon`
      - *string : textureAtlas*
    - `undressModel`
      - *boolean*
    - `subcategory`
      - *boolean*
    - `cameraZoomLevel`
      - *number*
    - `cameraDistanceOffset`
      - *number*
    - `spellShapeshiftFormID`
      - *number?*
    - `chrModelID`
      - *number?*
    - `options`
      - *CharCustomizationOption*
    - `hasNewChoices`
      - *boolean*
    - `needsNativeFormCategory`
      - *boolean*

- `CharCustomizationOption`
  - `Field`
  - `Type`
  - `Description`
  - `id`
    - *number*
  - `name`
    - *string*
  - `orderIndex`
    - *number*
  - `optionType`
    - *Enum.ChrCustomizationOptionType*
  - `choices`
    - *CharCustomizationChoice*
  - `currentChoiceIndex`
    - *number?*
  - `hasNewChoices`
    - *boolean*
  - `isSound`
    - *boolean*

- `Enum.ChrCustomizationOptionType`
  - `Value`
  - `Field`
  - `Description`
  - `0`
    - *SelectionPopout*
  - `1`
    - *Checkbox*
  - `2`
    - *Slider*

- `CharCustomizationChoice`
  - `Field`
  - `Type`
  - `Description`
  - `id`
    - *number*
  - `name`
    - *string*
  - `ineligibleChoice`
    - *boolean*
  - `isNew`
    - *boolean*
  - `swatchColor1`
    - *colorRGB?*
  - `swatchColor2`
    - *colorRGB?*
  - `soundKit`
    - *number?*
  - `isLocked`
    - *boolean*
  - `lockedText`
    - *string?*