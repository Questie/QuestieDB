## Event: COMBAT_LOG_EVENT

**Title:** COMBAT LOG EVENT

**Content:**
Fires for Combat Log events such as a player casting a spell or an NPC taking damage.
COMBAT_LOG_EVENT only reflects the filtered events in the combat log window
COMBAT_LOG_EVENT_UNFILTERED (CLEU) is unfiltered, making it preferred for use by addons.
Both events have identical parameters. The event payload is returned from CombatLogGetCurrentEventInfo(), or from CombatLogGetCurrentEntry() if selected using CombatLogSetCurrentEntry().

**Parameters & Values:**
- `1st Param`
  - *timestamp* - Unix Time in seconds with milliseconds precision, for example 1555749627.861. Similar to time() and can be passed as the second argument of date().
- `2nd Param`
  - *subevent* - The combat log event, for example SPELL_DAMAGE.
- `3rd Param`
  - *hideCaster* - boolean - Returns true if the source unit is hidden (an empty string).
- `4th Param`
  - *sourceGUID* - string - Globally unique identifier for units (NPCs, players, pets, etc), for example "Creature-0-3113-0-47-94-00003AD5D7".
- `5th Param`
  - *sourceName* - string - Name of the unit.
- `6th Param`
  - *sourceFlags* - number - Contains the flag bits for a unit's type, controller, reaction and affiliation. For example 68168 (0x10A48): Unit is the current target, is an NPC, the controller is an NPC, reaction is hostile and affiliation is outsider.
- `7th Param`
  - *sourceRaidFlags* - number - Contains the raid flag bits for a unit's raid target icon. For example 64 (0x40): Unit is marked with .
- `8th Param`
  - *destGUID* - string - Globally unique identifier for units (NPCs, players, pets, etc), for example "Creature-0-3113-0-47-94-00003AD5D7".
- `9th Param`
  - *destName* - string - Name of the unit.
- `10th Param`
  - *destFlags* - number - Contains the flag bits for a unit's type, controller, reaction and affiliation. For example 68168 (0x10A48): Unit is the current target, is an NPC, the controller is an NPC, reaction is hostile and affiliation is outsider.
- `11th Param`
  - *destRaidFlags* - number - Contains the raid flag bits for a unit's raid target icon. For example 64 (0x40): Unit is marked with .

**Payload:**
This comparison illustrates the difference between swing and spell events, e.g. the amount suffix parameter is on arg12 for SWING_DAMAGE and arg15 for SPELL_DAMAGE.
```lua
1617986084.18, "SWING_DAMAGE", false, "Player-1096-06DF65C1", "Xiaohuli", 1297, 0, "Creature-0-4253-0-160-94-000070569B", "Cutpurse", 68168, 0, 3, -1, 1, nil, nil, nil, true, false, false, false
1617986113.264, "SPELL_DAMAGE", false, "Player-1096-06DF65C1", "Xiaohuli", 1297, 0, "Creature-0-4253-0-160-94-000070569B", "Cutpurse", 68168, 0, 585, "Smite", 2, 47, 19, 2, nil, nil, nil, false, false, false, false
```
- **SWING_DAMAGE**
  - *Idx* - Param
  - *Param* - Value
  - *self* - <Frame>
  - *event* - "COMBAT_LOG_EVENT_UNFILTERED"
  - *1* - *timestamp* - 1617986084.18
  - *2* - *subevent* - "SWING_DAMAGE"
  - *3* - *hideCaster* - false
  - *4* - *sourceGUID* - "Player-1096-06DF65C1"
  - *5* - *sourceName* - "Xiaohuli"
  - *6* - *sourceFlags* - 1297
  - *7* - *sourceRaidFlags* - 0
  - *8* - *destGUID* - "Creature-0-4253-0-160-94-000070569B"
  - *9* - *destName* - "Cutpurse"
  - *10* - *destFlags* - 68168
  - *11* - *destRaidFlags* - 0
  - *12* - *amount* - 3
  - *13* - *overkill* - -1
  - *14* - *school* - 1
  - *15* - *resisted* - nil
  - *16* - *blocked* - nil
  - *17* - *absorbed* - nil
  - *18* - *critical* - true
  - *19* - *glancing* - false
  - *20* - *crushing* - false
  - *21* - *isOffHand* - false

- **SPELL_DAMAGE**
  - *Idx* - Param
  - *Param* - Value
  - *self* - <Frame>
  - *event* - "COMBAT_LOG_EVENT_UNFILTERED"
  - *1* - *timestamp* - 1617986113.264
  - *2* - *subevent* - "SPELL_DAMAGE"
  - *3* - *hideCaster* - false
  - *4* - *sourceGUID* - "Player-1096-06DF65C1"
  - *5* - *sourceName* - "Xiaohuli"
  - *6* - *sourceFlags* - 1297
  - *7* - *sourceRaidFlags* - 0
  - *8* - *destGUID* - "Creature-0-4253-0-160-94-000070569B"
  - *9* - *destName* - "Cutpurse"
  - *10* - *destFlags* - 68168
  - *11* - *destRaidFlags* - 0
  - *12* - *spellId* - 585
  - *13* - *spellName* - "Smite"
  - *14* - *spellSchool* - 2
  - *15* - *amount* - 47
  - *16* - *overkill* - 19
  - *17* - *school* - 2
  - *18* - *resisted* - nil
  - *19* - *blocked* - nil
  - *20* - *absorbed* - nil
  - *21* - *critical* - false
  - *22* - *glancing* - false
  - *23* - *crushing* - false
  - *24* - *isOffHand* - false

**Usage:**
Script:
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

**Content Details:**
Event Trace:
For the new event trace tool added in Patch 9.1.0 the following script can be loaded.
```lua
local function LogEvent(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" or event == "COMBAT_LOG_EVENT" then
        self:LogEvent_Original(event, CombatLogGetCurrentEventInfo())
    elseif event == "COMBAT_TEXT_UPDATE" then
        self:LogEvent_Original(event, (...), GetCurrentCombatTextEventInfo())
    else
        self:LogEvent_Original(event, ...)
    end
end
local function OnEventTraceLoaded()
    EventTrace.LogEvent_Original = EventTrace.LogEvent
    EventTrace.LogEvent = LogEvent
end
if EventTrace then
    OnEventTraceLoaded()
else
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ADDON_LOADED")
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "ADDON_LOADED" and (...) == "Blizzard_EventTrace" then
            OnEventTraceLoaded()
            self:UnregisterAllEvents()
        end
    end)
end
```
SPELL_ABSORBED:
This relatively new subevent fires in addition to SWING_MISSED / SPELL_MISSED which already have the "ABSORB" missType and same amount. It optionally includes the spell payload if triggered from what would be SPELL_DAMAGE.
```lua
timestamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, , casterGUID, casterName, casterFlags, casterRaidFlags, absorbSpellId, absorbSpellName, absorbSpellSchool, amount, critical
```
-- swing
```lua
1620562047.156, "SWING_MISSED", false, "Creature-0-4234-0-138-44176-000016DAE1", "Bluegill Wanderer", 2632, 0, "Player-1096-06DF65C1", "Xiaohuli", 66833, 0, "ABSORB", false, 13, false
1620562047.156, "SPELL_ABSORBED", false, "Creature-0-4234-0-138-44176-000016DAE1", "Bluegill Wanderer", 2632, 0, "Player-1096-06DF65C1", "Xiaohuli", 66833, 0, "Player-1096-06DF65C1", "Xiaohuli", 66833, 0, 17, "Power Word: Shield", 2, 13, false
-- spell
1620561974.121, "SPELL_MISSED", false, "Creature-0-4234-0-138-44176-000016DAE1", "Bluegill Wanderer", 2632, 0, "Player-1096-06DF65C1", "Xiaohuli", 66833, 0, 83669, "Water Bolt", 16, "ABSORB", false, 15, false
1620561974.121, "SPELL_ABSORBED", false, "Creature-0-4234-0-138-44176-000016DAE1", "Bluegill Wanderer", 2632, 0, "Player-1096-06DF65C1", "Xiaohuli", 66833, 0, 83669, "Water Bolt", 16, "Player-1096-06DF65C1", "Xiaohuli", 66833, 0, 17, "Power Word: Shield", 2, 15, false
```
SWING_DAMAGE
Idx
Param
Value
self
<Frame>
event
"COMBAT_LOG_EVENT_UNFILTERED"
1
timestamp
1617986084.18
2
subevent
"SWING_DAMAGE"
3
hideCaster
false
4
sourceGUID
"Player-1096-06DF65C1"
5
sourceName
"Xiaohuli"
6
sourceFlags
1297
7
sourceRaidFlags
0
8
destGUID
"Creature-0-4253-0-160-94-00006FB363"
9
destName
"Cutpurse"
10
destFlags
68168
11
destRaidFlags
0
12
amount
3
13
overkill
-1
14
school
1
15
resisted
nil
16
blocked