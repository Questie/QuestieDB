## Title: GetFontInfo

**Content:**
Returns a structured table of information about the given font object.
`fontInfo = GetFontInfo(font)`

**Parameters:**
- `font`
  - *Font🔗|string* - Either a font object or the name of a global font object.

**Returns:**
- `fontInfo`
  - *FontInfo*
    - `Field`
    - `Type`
    - `Description`
    - `height`
      - *number* - Height (size) of the font object
    - `outline`
      - *string* - Comma delimited list of font flags such as OUTLINE, THICKOUTLINE, and MONOCHROME
    - `color`
      - *ColorInfo* - Table of color values for the font object
    - `shadow`
      - *FontShadow?* - Optional table of shadow information for the font object
        - `FontShadow`
          - `Field`
          - `Type`
          - `Description`
          - `x`
            - *number* - Horizontal offset for the shadow
          - `y`
            - *number* - Vertical offset for the shadow
          - `color`
            - *ColorInfo* - Table of color values for the shadow
            - `ColorInfo`
              - `Field`
              - `Type`
              - `Description`
              - `r`
                - *number*
              - `g`
                - *number*
              - `b`
                - *number*
              - `a`
                - *number*

**Description:**
If a font has no outline or monochrome flags applied, the outline field in the returned table will always be an empty string.

**Reference:**
GetFonts