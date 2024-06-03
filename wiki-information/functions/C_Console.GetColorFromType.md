## Title: C_Console.GetColorFromType

**Content:**
Returns color info for a color type.
`color = C_Console.GetColorFromType(colorType)`

**Parameters:**
- `colorType`
  - *Enum.ConsoleColorType*
    - `Value`
    - `Field`
    - `Description`
    - `0` - DefaultColor
    - `1` - InputColor
    - `2` - EchoColor
    - `3` - ErrorColor
    - `4` - WarningColor
    - `5` - GlobalColor
    - `6` - AdminColor
    - `7` - HighlightColor
    - `8` - BackgroundColor
    - `9` - ClickbufferColor
    - `10` - PrivateColor
    - `11` - DefaultGreen

**Returns:**
- `color`
  - *ColorMixin*