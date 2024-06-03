## Title: UnitIsTapDenied

**Content:**
Indicates a mob is no longer eligible for tap.
`unitIsTapDenied = UnitIsTapDenied(unit)`

**Parameters:**
- `unit`
  - *string* : UnitToken

**Returns:**
- `unitIsTapDenied`
  - *boolean*

**Usage:**
The following code in FrameXML grays out the target frame when the target is tap denied:
```lua
function TargetFrame_CheckFaction (self)
    if ( not UnitPlayerControlled(self.unit) and UnitIsTapDenied(self.unit) ) then
        self.nameBackground:SetVertexColor(0.5, 0.5, 0.5);
        if ( self.portrait ) then
            self.portrait:SetVertexColor(0.5, 0.5, 0.5);
        end
    else
        self.nameBackground:SetVertexColor(UnitSelectionColor(self.unit));
        if ( self.portrait ) then
            self.portrait:SetVertexColor(1.0, 1.0, 1.0);
        end
    end
    -- the function continues with activities not relevant to this example
end
```

**Example Use Case:**
This function is particularly useful in scenarios where you need to visually indicate to the player that a mob is no longer eligible for them to gain credit for a kill. For instance, in a custom UI addon, you might want to change the appearance of the target frame to show that the mob is tap denied, similar to how the default UI does it.

**Addons Using This Function:**
Many popular addons that modify the unit frames, such as ElvUI and Shadowed Unit Frames, use this function to provide visual feedback to the player about the tap status of their target. This helps players quickly identify whether they can gain credit for attacking a mob or not.