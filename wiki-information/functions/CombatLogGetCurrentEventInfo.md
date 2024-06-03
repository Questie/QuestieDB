## Title: CombatLogGetCurrentEventInfo

**Content:**
Returns the current COMBAT_LOG_EVENT payload.
`arg1, arg2, ... = CombatLogGetCurrentEventInfo()`

**Returns:**
Returns a variable number of values: 11 base values and up to 13 extra values based upon the subtype of the event.

**Description:**
In the new event system for 8.0, supporting the original functionality of the CLEU event was problematic due to the "context" arguments, i.e. each argument can be interpreted differently depending on the previous arguments. The payload was subsequently moved to this function.

**Usage:**
Prints all CLEU parameters.
```lua
local function OnEvent(self, event)
    print(CombatLogGetCurrentEventInfo())
end
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", OnEvent)
```

Displays your spell or melee critical hits.
```lua
local playerGUID = UnitGUID("player")
local MSG_CRITICAL_HIT = "Your %s critically hit %s for %d damage!"
local f = CreateFrame("Frame")
f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
f:SetScript("OnEvent", function(self, event)
    local _, subevent, _, sourceGUID, _, _, _, _, destName = CombatLogGetCurrentEventInfo()
    local spellId, amount, critical
    if subevent == "SWING_DAMAGE" then
        amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
    elseif subevent == "SPELL_DAMAGE" then
        spellId, _, _, amount, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo())
    end
    if critical and sourceGUID == playerGUID then
        -- get the link of the spell or the MELEE globalstring
        local action = spellId and GetSpellLink(spellId) or MELEE
        print(MSG_CRITICAL_HIT:format(action, destName, amount))
    end
end)
```

**Example Use Case:**
This function is commonly used in combat log analysis addons such as Recount and Details! Damage Meter. These addons use `CombatLogGetCurrentEventInfo` to parse combat log events and provide detailed statistics on damage, healing, and other combat metrics.