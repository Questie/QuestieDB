## Title: C_NamePlate.GetNamePlates

**Content:**
Returns the currently visible nameplates.
`nameplates = C_NamePlate.GetNamePlates()`

**Parameters:**
- `isSecure`
  - *boolean?* - Whether protected nameplates for friendly units while in instanced areas should be returned.

**Returns:**
- `nameplates`
  - *NameplateBase : Frame|NamePlateBaseMixin*
    - `Field`
    - `Type`
    - `Description`
    - `UnitFrame`
      - *Button*
    - `driverFrame`
      - *NamePlateDriverFrame* - points to NamePlateDriverFrame (NamePlateDriverMixin)
    - `namePlateUnitToken`
      - *string* - e.g. "nameplate1"
    - `template`
      - *string* - e.g. "NamePlateUnitFrameTemplate"
    - `NamePlateBaseMixin`
      - `OnAdded`
        - *function*
      - `OnRemoved`
        - *function*
      - `OnOptionsUpdated`
        - *function*
      - `ApplyOffsets`
        - *function*
      - `GetAdditionalInsetPadding`
        - *function*
      - `GetPreferredInsets`
        - *function*
      - `OnSizeChanged`
        - *function*

**Example Usage:**
This function can be used to retrieve all currently visible nameplates, which is useful for addons that need to interact with or display information about nameplates. For example, an addon that customizes nameplate appearance or adds additional information like health percentages or debuffs would use this function to get the list of nameplates to modify.

**Addons Using This Function:**
- **TidyPlates**: A popular addon that enhances the default nameplates with additional customization options and information. It uses `C_NamePlate.GetNamePlates` to retrieve the current nameplates and apply its custom styles and data overlays.
- **Plater Nameplates**: Another widely used nameplate addon that offers extensive customization and scripting capabilities. It leverages this function to manage and update the nameplates dynamically based on user settings and scripts.