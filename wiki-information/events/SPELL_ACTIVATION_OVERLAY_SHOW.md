## Event: SPELL_ACTIVATION_OVERLAY_SHOW

**Title:** SPELL ACTIVATION OVERLAY SHOW

**Content:**
Fired when the spell overlay is shown.
`SPELL_ACTIVATION_OVERLAY_SHOW: spellID, overlayFileDataID, locationName, scale, r, g, b`

**Payload:**
- `spellID`
  - *number*
- `overlayFileDataID`
  - *number* - texture
- `locationName`
  - *string* - possible values include simple points such as "CENTER" or "LEFT", or complex positions such as "RIGHT (FLIPPED)" or "TOP + BOTTOM (FLIPPED)", which are defined in a local table in SpellActivationOverlay.lua
- `scale`
  - *number*
- `r`
  - *number*
- `g`
  - *number*
- `b`
  - *number*