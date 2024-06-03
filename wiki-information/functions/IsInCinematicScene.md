## Title: IsInCinematicScene

**Content:**
Returns true during in-game cinematics/cutscenes involving NPC actors and scenescripts.
`inCinematicScene = IsInCinematicScene()`

**Returns:**
- `inCinematicScene`
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