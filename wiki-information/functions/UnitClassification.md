## Title: UnitClassification

**Content:**
Returns the classification of the specified unit (e.g., "elite" or "worldboss").
`classification = UnitClassification(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `classification`
  - *string* - the unit's classification: "worldboss", "rareelite", "elite", "rare", "normal", "trivial", or "minus"
    - Note that "trivial" is for low-level targets that would not reward experience or honor (UnitIsTrivial() would return '1'), whereas "minus" is for mobs that show a miniature version of the v-key health plates.

**Usage:**
```lua
if ( UnitClassification("target") == "worldboss" ) then
  -- If unit is a world boss show skull regardless of level
  TargetLevelText:Hide();
  TargetHighLevelTexture:Show();
end
```

**Result:**
If the target is a world boss, then the level isn't shown in the target frame, instead a special high level texture is shown.