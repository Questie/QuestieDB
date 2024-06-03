## Title: InCinematic

**Content:**
Returns true during simple in-game cinematics where only the camera moves, like the race intro cinematics.
`inCinematic = InCinematic()`

**Returns:**
- `inCinematic`
  - *boolean*

**Usage:**
Prints what type of cinematic is playing on `CINEMATIC_START`.
```lua
local function OnEvent(self, event, ...)
    if InCinematic() then
        print("simple cinematic")
    elseif IsInCinematicScene() then
        print("fancy in-game cutscene")
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("CINEMATIC_START")
f:SetScript("OnEvent", OnEvent)
```