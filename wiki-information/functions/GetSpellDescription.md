## Title: GetSpellDescription

**Content:**
Returns the spell description.
`desc = GetSpellDescription(spellID)`

**Parameters:**
- `spellID`
  - *number* - Not readily available on function call, see `SpellMixin:ContinueOnSpellLoad`.

**Returns:**
- `desc`
  - *string*

**Usage:**
```lua
GetSpellDescription(11366)
-- > "Hurls an immense fiery boulder that causes 141 Fire damage."
```

**Example Use Case:**
This function can be used in addons that need to display or log spell descriptions. For instance, an addon that provides detailed tooltips for spells might use `GetSpellDescription` to fetch and display the spell's effect.

**Addons Using This Function:**
- **WeakAuras**: This popular addon for creating custom visual alerts uses `GetSpellDescription` to provide detailed information about spells in its configuration options, allowing users to understand the effects of spells they are tracking.