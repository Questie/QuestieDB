## Title: CastShapeshiftForm

**Content:**
Casts a shapeshift ability.
`CastShapeshiftForm(index)`

**Parameters:**
- `index`
  - *number* - specifies which shapeshift form to activate or toggle; generally equivalent to the index of the form on the stance bar.

**Example Usage:**
```lua
-- Example: Cast the first shapeshift form (e.g., Bear Form for Druids)
CastShapeshiftForm(1)
```

**Description:**
This function is typically used by classes that have shapeshifting abilities, such as Druids. It allows the player to switch between different forms, such as Bear Form, Cat Form, etc., by specifying the index of the form.

**Addons:**
Many addons that enhance class-specific functionalities, such as "WeakAuras" or "TellMeWhen," use this function to automate or provide visual cues for shapeshifting abilities. For example, an addon might automatically switch the player to Bear Form when their health drops below a certain threshold.