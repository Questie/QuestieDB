## Event: PLAYER_ENTERING_WORLD

**Title:** PLAYER ENTERING WORLD

**Content:**
Fires when the player logs in, /reloads the UI or zones between map instances. Basically whenever the loading screen appears.
`PLAYER_ENTERING_WORLD: isInitialLogin, isReloadingUi`

**Payload:**
- `isInitialLogin`
  - *boolean* - True whenever the character logs in. This includes logging out to character select and then logging in again.
- `isReloadingUi`
  - *boolean*

**Usage:**
```lua
local function OnEvent(self, event, isLogin, isReload)
    if isLogin or isReload then
        print("loaded the UI")
    else
        print("zoned between map instances")
    end
end
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", OnEvent)
```

**Related Information:**
AddOn loading process