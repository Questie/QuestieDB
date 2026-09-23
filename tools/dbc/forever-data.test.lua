-- Dataset review checks, not an assertion that Forever must keep matching Era.
dofile("src/support/eraToForever.test.lua")
local loader = dofile("generator/loader.lua")
local config = dofile("src/config.lua")
local npcType
for _, entity in ipairs(config.entityTypes) do
    if entity.name == "Npc" then npcType = entity end
end
local npcs = loader.loadEntityData("data/Forever/foreverNpcDB.lua", assert(npcType))

---@type table<string, table>
local modules = { ZoneDB = { private = {} }, QuestieDB = {} }
QuestieLoader = {
    ---@param _ table
    ---@param name string
    ---@return table
    ImportModule = function(_, name) return assert(modules[name]) end,
}
local root = "support/Forever/"
dofile(root .. "Zones/zoneIds.lua")
for _, name in ipairs({"areaIdToUiMapId", "uiMapIdToAreaId", "subZoneToParentZone"}) do
    dofile(root .. "Zones/" .. name .. ".lua")
    local private = modules.ZoneDB.private
    assert(type(private[name]) == "string", name .. " must remain a deferred string")
    assert(type(private[name .. "Override"]) == "string", name .. " override must remain a deferred string")
end
dofile(root .. "Zones/instanceIdToAreaId.lua")
dofile(root .. "FactionTemplates/factionTemplateClassic.lua")
local private = modules.ZoneDB.private
local areas = assert(loadstring(private.areaIdToUiMapId))()
local maps = assert(loadstring(private.uiMapIdToAreaId))()
for area, map in pairs({[616]=2482, [16591]=2548, [16593]=2521, [16606]=2524, [16651]=2652}) do
    assert(areas[area] == map and maps[map] == area, "Reviewed Forever map link differs")
end
assert(maps[198] == nil and maps[2665] == nil, "Cata Hyjal or unresolved Zephras map introduced")
local overrides = assert(loadstring(private.uiMapIdToAreaIdOverride))()
assert(overrides[1414] == 10073 and overrides[1415] == 10074 and overrides[947] == 10089,
    "Authored continent routing was erased")
assert(overrides[281] == 10000, "Referenced Maraudon entrance alias was erased")
local forwardOverrides = assert(loadstring(private.areaIdToUiMapIdOverride))()
for area, map in pairs(forwardOverrides) do
    assert(map == 0 or areas[area] == nil, "Compatibility shadows a current DBC area")
    areas[area] = map
end
for map, area in pairs(overrides) do
    assert(maps[map] == nil, "Compatibility shadows a canonical DBC map")
    maps[map] = area
end
local parents = assert(loadstring(private.subZoneToParentZone))()
for area, parent in pairs(assert(loadstring(private.subZoneToParentZoneOverride))()) do
    parents[area] = parent
end
for area, map in pairs({[220]=1412, [222]=1412, [1037]=1437, [2657]=2652, [3217]=1444}) do
    assert(areas[area] == map, "Completed DBC relationship differs: " .. area)
end
assert(parents[2657] == 16651 and parents[3217] == 357, "Reviewed parent routing differs")
assert(areas[parents[2657]] == areas[2657] and areas[parents[3217]] == areas[3217],
    "Direct and parent routing disagree")
for _, area in ipairs({15475,15531,15828,16074,16236}) do
    assert(forwardOverrides[area] == nil, "Unused SoD routing restored")
end
assert(areas[10001] == nil and maps[318] == nil, "Unused floor compatibility restored")
local instances = modules.ZoneDB.instanceIdToAreaId
for instance, area in pairs({[369]=2257, [449]=2918, [450]=2917, [489]=3277, [529]=3358, [2959]=16544}) do
    assert(instances[instance] == area, "Reviewed explicit instance link differs")
end
assert(instances[33] == 209 and instances[36] == 1581, "Partial export erased authored dungeon links")
assert(instances[13] == nil and instances[35] == nil, "Deferred test/unused maps introduced")

-- Check actual references, not just whether two faction-table files have similar sizes.
local factions = modules.QuestieDB.factionTemplate
---@param rows table<number, table>
---@return nil
local function checkFactionReferences(rows)
    for id, row in pairs(rows) do
        local faction = row[12]
        assert(faction == nil or factions[faction] ~= nil,
            "NPC " .. id .. " references missing faction template " .. tostring(faction))
    end
end
assert(factions[3546] == nil, "Removed DBC faction template unexpectedly restored")
checkFactionReferences(npcs)
local ok = pcall(checkFactionReferences, {[1] = {[12] = 3546}})
assert(not ok, "Faction-reference self-proof failed")

local runtime = dofile("generator/runtime.lua")
local lib = runtime.build()
local compat = lib.CorrectionCompat
local remove = compat.Install(config.flavorByName.Vanilla)
compat.BeginCapture()
runtime.execute("src/corrections/Forever/legacy/classicNPCFixes.lua", "QuestieDB", lib)
remove()
checkFactionReferences(compat.captured.Npc or {})
for _, method in ipairs({"Load", "LoadFactionFixes"}) do
    for _, faction in ipairs({"Alliance", "Horde"}) do
        ---@return string
        UnitFactionGroup = function() return faction end
        ---@return string
        UnitClassBase = function() return "WARRIOR" end
        compat.BeginCapture()
        local provider = compat.modules.QuestieNPCFixes
        checkFactionReferences(compat.Invoke(provider[method], provider) or {})
        checkFactionReferences(compat.captured.Npc or {})
    end
end
-- Exercise owned corrected spawn fields and authored entrance triples, not ID text matches.
modules.Expansions = {Current=1, Wotlk=3, Cata=4}
QuestieLoader = {
    ---@param _ table
    ---@param name string
    ---@return table
    ImportModule = function(_, name) return assert(modules[name]) end,
}
dofile(root .. "Zones/dungeons.lua")
local dungeons = private.dungeons
-- Reviewed Era-to-Forever entrance projections, stored at the baseline's two-decimal precision.
-- Use each entrance's AreaID: Naxxramas still has legacy parent 65, but its entrance is in EPL.
local expectedEntrances = {
    [717] = {{1519, 52.41, 70.01}},
    [2017] = {{139, 26.52, 10.36}, {139, 41.45, 17.74}},
    [2257] = {{1519, 71.98, 27.61}, {1537, 84.1, 53.1}},
    [2918] = {{1519, 75.93, 66.22}},
    [3456] = {{139, 34.25, 19.45}},
    [16236] = {{139, 60.14, 75.32}},
    -- These are later-expansion frames, not eligible for the Era transform.
    [5861] = {{12, 41.79, 69.52}, {215, 36.85, 35.86}},
    [6618] = {{1519, 69.49, 31.2}, {1537, 84.1, 53.1}},
    [10001] = {{139, 43.5, 19.4}},
}
for area, expected in pairs(expectedEntrances) do
    local actual = dungeons[area][4]
    assert(#actual == #expected, "Entrance count differs for " .. area)
    for index, point in ipairs(expected) do
        assert(actual[index][1] == point[1] and actual[index][2] == point[2] and actual[index][3] == point[3],
            "Reviewed entrance differs for " .. area .. " point " .. index)
    end
end
local entrances = {}
for area, dungeon in pairs(dungeons) do
    entrances[area] = dungeon[4]
end
for _, dungeon in pairs(dungeons) do
    for _, alias in ipairs(dungeon[2] or {}) do
        entrances[alias] = entrances[alias] or dungeon[4]
    end
end

-- Mirrors the consumer's pre-entrance map-key requirement. Missing compatibility
-- must fail before a perfectly usable outdoor entrance can hide the regression.
---@param area number
---@return nil
local function checkEntrance(area)
    local indexedByMap = {}
    indexedByMap[areas[area]] = true
    assert(maps[areas[area]] == area, "Dungeon reverse lookup missing: " .. area)
    for _, entrance in ipairs(assert(entrances[area], "Dungeon entrance missing")) do
        assert(areas[entrance[1]] and areas[entrance[1]] > 0, "Entrance map missing")
        assert(entrance[2] >= 0 and entrance[3] >= 0, "Entrance is still a sentinel")
    end
end
local referenced = {}
local suppressedAreas = {[0]=true, [2257]=true, [2917]=true, [2918]=true}

-- Derive required routing from spawns, not the compatibility inventory under test.
---@param rows table<number, table>
---@param spawnField number
---@return nil
local function checkSpawnEntrances(rows, spawnField)
    for _, row in pairs(rows) do
        for area in pairs(row[spawnField] or {}) do
            if entrances[area] and not suppressedAreas[area] then
                checkEntrance(area)
                referenced[area] = true
            end
        end
    end
end

local correctedEntities = {}
for _, entity in ipairs(config.entityTypes) do
    if entity.name == "Npc" or entity.name == "Object" then
        local rows = loader.loadEntityData("data/Forever/forever" .. entity.fileSuffix .. ".lua", entity)
        local providerLib = runtime.build()
        local providerCompat = providerLib.CorrectionCompat
        local undo = providerCompat.Install(config.flavorByName.Forever)
        providerCompat.BeginCapture()
        local filename = entity.name == "Npc" and "classicNPCFixes" or "classicObjectFixes"
        runtime.execute("src/corrections/Forever/legacy/" .. filename .. ".lua", "QuestieDB", providerLib)
        local provider = providerCompat.modules[entity.name == "Npc" and "QuestieNPCFixes" or "QuestieObjectFixes"]
        local corrections = providerCompat.Invoke(provider.Load, provider)
        undo()
        for id, fields in pairs(corrections) do
            rows[id] = rows[id] or {}
            for field, value in pairs(fields) do rows[id][field] = value end
        end
        checkSpawnEntrances(rows, entity.name == "Npc" and 7 or 4)
        correctedEntities[entity.name] = rows
    end
end
for area, map in pairs(forwardOverrides) do
    if map > 0 and area ~= 10073 and area ~= 10074 and area ~= 10089 then
        assert(referenced[area], "Compatibility has no current spawn reference: " .. area)
    end
end
-- Follow real NPC and object objectives to their corrected spawn maps.
local quests
for _, entity in ipairs(config.entityTypes) do
    if entity.name == "Quest" then
        quests = loader.loadEntityData("data/Forever/foreverQuestDB.lua", entity)
    end
end
for _, case in ipairs({{7461,"Npc",1,7,11486,10022}, {5382,"Object",2,4,176545,10012}}) do
    local found = false
    for _, target in ipairs(quests[case[1]][10][case[3]]) do
        if target[1] == case[5] then
            local spawns = correctedEntities[case[2]][target[1]][case[4]]
            assert(spawns[case[6]], "Representative objective lost its alias spawn")
            for area, points in pairs(spawns) do
                for _, point in ipairs(points) do
                    assert(point[1] == -1 and point[2] == -1, "Expected instance marker")
                end
                checkEntrance(area)
            end
            found = true
        end
    end
    assert(found, "Representative quest objective changed")
end
-- Both ordinary dungeon and synthetic-area omissions must fail the same spawn scanner.
for _, area in ipairs({209, 10022}) do
    local saved = areas[area]
    areas[area] = nil
    local entranceOk, entranceError = pcall(checkSpawnEntrances, correctedEntities.Npc, 7)
    areas[area] = saved
    assert(not entranceOk and entranceError:find("table index is nil", 1, true),
        "Missing-compatibility self-proof failed: " .. area)
end
checkEntrance(10022)
checkEntrance(10032)
print("Forever support shapes, DBC links, entrance compatibility and faction references passed (including self-proofs)")
