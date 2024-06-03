## Title: C_UIColor.GetColors

**Content:**
Returns a list of UI colors to be imported into the global environment on login.
`colors = C_UIColor.GetColors()`

**Returns:**
- `colors`
  - *DBColorExport* - A list of UI color structures.
    - `Field`
    - `Type`
    - `Description`
    - `baseTag`
      - *string* - The global name to associate with this color.
    - `color`
      - *ColorMixin* - The color data.

**Description:**
UI colors are stored within the global color client database.