-- Reviewed Forever support data, not a requirement to keep matching Era.
-- Fixtures come first; checks follow the consumer's data dependencies:
-- maps and identities, faction references, entrances, corrected objectives, then failure detection.
local zoneValidation = dofile("validators/zones.lua")
local loader = dofile("generator/loader.lua")
local config = dofile("src/config.lua")
local runtime = dofile("generator/runtime.lua")

local root = "support/Forever/"
local areaPath = root .. "Zones/areaIdToUiMapId.lua"
local mapPath = root .. "Zones/uiMapIdToAreaId.lua"
local parentPath = root .. "Zones/subZoneToParentZone.lua"
local instancePath = root .. "Zones/instanceIdToAreaId.lua"
local dungeonPath = root .. "Zones/dungeons.lua"
local factionPath = root .. "FactionTemplates/factionTemplateClassic.lua"

--------------------------------------------------------------------------------------------
-- Fixtures: area routes and lookup aliases
--------------------------------------------------------------------------------------------
-- Reviewed identities come from Forever support comments and the zone enum.
-- Expected values stay literal and independent of the support tables under test.
local reviewedForwardMapLinks = {
    [616] = 2482, -- Mount Hyjal area -> Mount Hyjal UiMap
    [16591] = 2548, -- Riverglades area -> Riverglades UiMap
    [16593] = 2521, -- Zephras Isle area -> Zephras Isle UiMap
    [16606] = 2524, -- Darkspear Islands area -> Darkspear Islands UiMap
    [16651] = 2652, -- Shen'dralas area -> Shen'dralas UiMap
}
local continentOverrides = {
    [1414] = 10073, -- Kalimdor UiMap -> Kalimdor area
    [1415] = 10074, -- Eastern Kingdoms UiMap -> Eastern Kingdoms area
    [947] = 10089, -- Azeroth UiMap -> Azeroth area
}
local dbcRelationshipMaps = {
    [220] = 1412, -- Red Cloud Mesa area -> Mulgore UiMap
    [222] = 1412, -- Bloodhoof Village area -> Mulgore UiMap
    [1037] = 1437, -- Grim Batol area -> Wetlands UiMap
    [2657] = 2652, -- Valley of Bones area -> Shen'dralas UiMap
    [3217] = 1444, -- The Maul area -> Feralas UiMap
}
local parentLinks = {
    [2657] = 16651, -- Valley of Bones area -> Shen'dralas area
    [3217] = 357, -- The Maul area -> Feralas area
}
local unusedSodAreas = {
    15475, -- Demon Fall Canyon area
    15531, -- The Tainted Scar area
    15828, -- The Burning of Andorhal area
    16074, -- Karazhan Crypts area
    16236, -- Scarlet Enclave area
}
--------------------------------------------------------------------------------------------
-- Fixtures: area/instance identities and strict no-map policy
--------------------------------------------------------------------------------------------

local zoneEnumIdentities = {
    EXCAVATION_SITE_WETLANDS = 16732, -- Excavation Site: Wetlands dungeon area
    EXCAVATION_SITE_WETLANDS_EXTERIOR = 17732, -- Excavation Site: Wetlands exterior area
    RUINS_OF_LORDAERON_KINGS_ALLEY = 16612, -- King's Alley subarea
    TWILIGHT_HOLLOW = 17847, -- Twilight Hollow area
    GILNEAS = 4714, -- Legacy Gilneas area
    GILNEAS_FOREVER = 17065, -- Forever Gilneas area
    BLACKROCK_DEPTHS = 1584, -- Legacy Blackrock Depths area
    BLACKROCK_DEPTHS_FOREVER = 17803, -- Forever Blackrock Depths area
    NAXXRAMAS = 3456, -- Legacy Naxxramas area
    NAXXRAMAS_SOD = 16394, -- Separate SoD Naxxramas area, instance MapID 2921
}
local instanceIdentities = {
    [369] = 2257, -- Deeprun Tram instance -> Deeprun Tram area
    [449] = 2918, -- Alliance PVP Barracks instance -> Champions' Hall area
    [450] = 2917, -- Horde PVP Barracks instance -> Hall of Legends area
    [489] = 3277, -- Warsong Gulch instance -> Warsong Gulch area
    [529] = 3358, -- Arathi Basin instance -> Arathi Basin area
    [2959] = 16544, -- City of Dalaran instance -> City of Dalaran area
}
local noMapDungeonIdentities = {
    {
        instance = 2959, -- City of Dalaran instance
        area = 16544, -- City of Dalaran area
        name = "City of Dalaran",
    },
    {
        instance = 2998, -- Excavation Site: Wetlands instance
        area = 16732, -- Excavation Site: Wetlands area
        name = "Excavation Site: Wetlands",
    },
    {
        instance = 2999, -- Ruins of Lordaeron instance
        area = 16611, -- Ruins of Lordaeron area
        name = "Ruins of Lordaeron",
    },
    {
        instance = 3065, -- The Hall of Thanes instance
        area = 16919, -- The Hall of Thanes area
        name = "The Hall of Thanes",
    },
}
local dungeonChildParents = {
    [16612] = 16611, -- King's Alley area -> Ruins of Lordaeron area
    [16614] = 16611, -- Lordaeron Graveyard area -> Ruins of Lordaeron area
    [16615] = 16611, -- Lordamere Overlook area -> Ruins of Lordaeron area
    [16617] = 16611, -- Market Street area -> Ruins of Lordaeron area
    [16877] = 16732, -- Lost Marsh area -> Excavation Site: Wetlands area
    [16878] = 16732, -- Stalker's Thicket area -> Excavation Site: Wetlands area
    [16879] = 16732, -- Site of the Guardian area -> Excavation Site: Wetlands area
    [16880] = 16732, -- Lost Dig Site area -> Excavation Site: Wetlands area
}
-- Only the fail-safe and intentional display suppression may use 0.
-- No-map dungeons resolve through entrances.
local suppressedAreas = {
    [0] = "fail-safe", -- Sentinel, not a game area
    [2257] = "Deeprun Tram",
    [2917] = "Hall of Legends",
    [2918] = "Champions' Hall",
}
--------------------------------------------------------------------------------------------
-- Fixtures: faction references and entrance geometry
--------------------------------------------------------------------------------------------

-- Synthetic NPC 1 references removed faction template 3546 for the self-proof.
local missingFactionReference = {
    [1] = {
        [12] = 3546, -- factionID field, not an NPC identity
    },
}
-- Reviewed Era-to-Forever entrance projections, stored at the baseline's two-decimal precision.
-- Use each entrance's AreaID: Naxxramas still has legacy parent 65, but its entrance is in EPL.
local expectedEntrances = {
    [717] = { -- The Stockade area
        {1519, 52.41, 70.01}, -- Stormwind City outdoor area
    },
    [2017] = { -- Stratholme area
        {139, 26.52, 10.36}, -- Eastern Plaguelands outdoor area
        {139, 41.45, 17.74}, -- Eastern Plaguelands outdoor area
    },
    [2257] = { -- Deeprun Tram area
        {1519, 71.98, 27.61}, -- Stormwind City outdoor area
        {1537, 84.1, 53.1}, -- Ironforge outdoor area
    },
    [2918] = { -- Champions' Hall area
        {1519, 75.93, 66.22}, -- Stormwind City outdoor area
    },
    [3456] = { -- Naxxramas area
        {139, 34.25, 19.45}, -- Eastern Plaguelands outdoor area
    },
    [16236] = { -- Scarlet Enclave area; Forever content availability unverified
        {139, 60.14, 75.32}, -- Eastern Plaguelands outdoor area
    },
    -- Later-expansion frames, not eligible for the Era transform; Forever placement unverified.
    [5861] = { -- Darkmoon Faire Island area (Cata frame)
        {12, 41.79, 69.52}, -- Elwynn Forest outdoor area
        {215, 36.85, 35.86}, -- Mulgore outdoor area
    },
    [6618] = { -- Bizmo's Brawlpub area (MoP frame)
        {1519, 69.49, 31.2}, -- Stormwind City outdoor area
        {1537, 84.1, 53.1}, -- Ironforge outdoor area
    },
    [10001] = { -- Stratholme: The Gauntlet synthetic floor alias (Cata frame)
        {139, 43.5, 19.4}, -- Eastern Plaguelands outdoor area
    },
}
--------------------------------------------------------------------------------------------
-- Fixtures: quest objectives and missing-route controls
--------------------------------------------------------------------------------------------

local representativeQuestObjectives = {
    {
        quest = 7461, -- The Madness Within
        entityType = "Npc",
        objectiveField = 1, -- NPC objectives within quest objectives[10]
        spawnField = 7, -- NPC spawns
        target = 11486, -- Prince Tortheldrin NPC
        area = 10022, -- Dire Maul: Gordok Commons synthetic dungeon alias
    },
    {
        quest = 5382, -- Doctor Theolen Krastinov, the Butcher
        entityType = "Object",
        objectiveField = 2, -- Object objectives within quest objectives[10]
        spawnField = 4, -- Object spawns
        target = 176545, -- Remains of Lucien Sarkhoff object
        area = 10012, -- Scholomance: The Upper Study synthetic dungeon alias
    },
}
local entranceFixtures = {
    209, -- Shadowfang Keep area
    10022, -- Dire Maul: Gordok Commons synthetic dungeon alias
}

local missingEntranceMap = {
    dungeonArea = 10022, -- Dire Maul: Gordok Commons synthetic dungeon alias.
    entranceArea = 357, -- Feralas outdoor area; removing its route must make the entrance unusable.
}

--------------------------------------------------------------------------------------------
-- Diagnostic labels and exact-value comparisons
--------------------------------------------------------------------------------------------
-- Labels are not expectations; the reviewed routing and coordinates are in the fixtures above.
local areaNames = {
    [0] = "fail-safe",
    [11] = "Wetlands",
    [12] = "Elwynn Forest",
    [139] = "Eastern Plaguelands",
    [215] = "Mulgore",
    [220] = "Red Cloud Mesa",
    [222] = "Bloodhoof Village",
    [357] = "Feralas",
    [616] = "Mount Hyjal",
    [1037] = "Grim Batol",
    [1519] = "Stormwind City",
    [1537] = "Ironforge",
    [2257] = "Deeprun Tram",
    [2657] = "Valley of Bones",
    [2917] = "Hall of Legends",
    [2918] = "Champions' Hall",
    [3217] = "The Maul",
    [3277] = "Warsong Gulch",
    [3358] = "Arathi Basin",
    [10073] = "Kalimdor",
    [10074] = "Eastern Kingdoms",
    [10089] = "Azeroth",
    [16591] = "Riverglades",
    [16593] = "Zephras Isle",
    [16606] = "Darkspear Islands",
    [16651] = "Shen'dralas",
    [17847] = "Twilight Hollow",
}
for _, dungeon in ipairs(noMapDungeonIdentities) do
    areaNames[dungeon.area] = dungeon.name
end
---@param area number
local function areaLabel(area)
    local name = areaNames[area]
    return name and (name .. " (area " .. tostring(area) .. ")") or ("area " .. tostring(area))
end

-- Formatting only: exact equality, including nil versus 0, is never relaxed.
local function expect(actual, expected, subject, path, reason)
    if actual ~= expected then
        error(subject .. ": expected " .. tostring(expected) .. ", actual " .. tostring(actual)
            .. "; " .. reason .. ". Inspect " .. path, 2)
    end
end

--------------------------------------------------------------------------------------------
-- Support-loader setup and deferred storage
--------------------------------------------------------------------------------------------

dofile("src/support/eraToForever.test.lua")
local namespace = { Enum = {} }
assert(loadfile("src/corrections/enum/zones.lua"))("QuestieDB", namespace)
---@type table<string, table>
local modules = { ZoneDB = { private = {}, zoneIDs = namespace.Enum.zoneIDs }, QuestieDB = {} }
local function installSupportLoader()
    QuestieLoader = {
        ---@param _ table
        ---@param name string
        ---@return table
        ImportModule = function(_, name) return assert(modules[name]) end,
    }
end
installSupportLoader()

for _, name in ipairs({"areaIdToUiMapId", "uiMapIdToAreaId", "subZoneToParentZone"}) do
    dofile(root .. "Zones/" .. name .. ".lua")
    local private = modules.ZoneDB.private
    expect(type(private[name]), "string", name, root .. "Zones/" .. name .. ".lua",
        "support tables must remain deferred strings")
    expect(type(private[name .. "Override"]), "string", name .. "Override", root .. "Zones/" .. name .. ".lua",
        "support overrides must remain deferred strings")
end
dofile(root .. "Zones/instanceIdToAreaId.lua")
dofile(root .. "FactionTemplates/factionTemplateClassic.lua")
local private = modules.ZoneDB.private
local areas = assert(loadstring(private.areaIdToUiMapId))()
local nativeAreas = assert(loadstring(private.areaIdToUiMapId))()
local maps = assert(loadstring(private.uiMapIdToAreaId))()

--------------------------------------------------------------------------------------------
-- Native map links and authored override policy
--------------------------------------------------------------------------------------------

for area, map in pairs(reviewedForwardMapLinks) do
    expect(areas[area], map, "areaIdToUiMapId[" .. area .. "] for " .. areaLabel(area), areaPath,
        "reviewed Forever area routing must match exactly")
    expect(maps[map], area, "uiMapIdToAreaId[" .. map .. "] for " .. areaLabel(area), mapPath,
        "the canonical reverse link must identify the reviewed area")
end
expect(maps[198], nil, "uiMapIdToAreaId[198] (Cata Hyjal)", mapPath,
    "the reviewed Forever base table excludes the Cata map")
expect(maps[2665], nil, "uiMapIdToAreaId[2665] (unresolved Zephras map)", mapPath,
    "an unresolved map must not receive a canonical area link")
local overrides = assert(loadstring(private.uiMapIdToAreaIdOverride))()
for map, area in pairs(continentOverrides) do
    expect(overrides[map], area, "uiMapIdToAreaIdOverride[" .. map .. "] for " .. areaLabel(area), mapPath,
        "authored continent/world aliases must remain intact")
end
expect(overrides[281], 10000, "uiMapIdToAreaIdOverride[281] (Maraudon alias)", mapPath,
    "the currently referenced Maraudon alias must remain intact")
local forwardOverrides = assert(loadstring(private.areaIdToUiMapIdOverride))()
for area, map in pairs(forwardOverrides) do
    assert(map ~= 0 or suppressedAreas[area],
        "areaIdToUiMapIdOverride[" .. area .. "] for " .. areaLabel(area) .. ": actual UiMap " .. tostring(map)
        .. "; expected nonzero routing except for fail-safe 0, Deeprun Tram (2257), Hall of Legends (2917),"
        .. " or Champions' Hall (2918). No other suppression is allowed. Inspect " .. areaPath)
    assert(map == 0 or areas[area] == nil,
        "areaIdToUiMapIdOverride[" .. area .. "] for " .. areaLabel(area) .. ": actual override UiMap "
        .. tostring(map) .. ", base UiMap " .. tostring(areas[area])
        .. "; expected base nil for a nonzero override. Compatibility must not shadow current DBC routing. Inspect "
        .. areaPath)
    areas[area] = map
end
for map, area in pairs(overrides) do
    expect(maps[map], nil, "uiMapIdToAreaIdOverride[" .. map .. "] -> " .. areaLabel(area)
        .. " conflicts with base uiMapIdToAreaId[" .. map .. "]", mapPath,
        "compatibility must not shadow a canonical DBC map, even with an equal area value")
    maps[map] = area
end
--------------------------------------------------------------------------------------------
-- Area parents, zone constants and instance identities
--------------------------------------------------------------------------------------------

local parents = assert(loadstring(private.subZoneToParentZone))()
for area, parent in pairs(assert(loadstring(private.subZoneToParentZoneOverride))()) do
    parents[area] = parent
end
for area, map in pairs(dbcRelationshipMaps) do
    expect(areas[area], map, "areaIdToUiMapId[" .. area .. "] for " .. areaLabel(area), areaPath,
        "the reviewed DBC relationship must match exactly")
end
for child, parent in pairs(parentLinks) do
    expect(parents[child], parent, "subZoneToParentZone[" .. child .. "] for " .. areaLabel(child), parentPath,
        "the reviewed parent must remain " .. areaLabel(parent))
    expect(areas[parents[child]], areas[child], "parent UiMap for " .. areaLabel(child)
        .. " via " .. areaLabel(parents[child]), areaPath .. " and " .. parentPath,
        "direct and parent routes must select the same UiMap")
end
for _, area in ipairs(unusedSodAreas) do
    expect(forwardOverrides[area], nil, "areaIdToUiMapIdOverride[" .. area .. "]", areaPath,
        "unused SoD routing is excluded from reviewed Forever compatibility")
end
expect(areas[10001], nil, "areaIdToUiMapId[10001] (Stratholme: The Gauntlet)", areaPath,
    "unused floor compatibility must remain absent")
expect(maps[318], nil, "uiMapIdToAreaId[318] (unused floor compatibility)", mapPath,
    "unused floor compatibility must remain absent")
local zones = namespace.Enum.zoneIDs
for symbol, area in pairs(zoneEnumIdentities) do
    expect(zones[symbol], area, "zoneIDs." .. symbol, "src/corrections/enum/zones.lua",
        "distinct reviewed area identities must not be lost or conflated")
end
local instances = modules.ZoneDB.instanceIdToAreaId
for instance, area in pairs(instanceIdentities) do
    expect(instances[instance], area, "instanceIdToAreaId[" .. instance .. "] for " .. areaLabel(area), instancePath,
        "the reviewed explicit instance identity must match exactly")
end
expect(instances[33], 209, "instanceIdToAreaId[33] (Shadowfang Keep)", instancePath,
    "partial exports must preserve authored dungeon links")
expect(instances[36], 1581, "instanceIdToAreaId[36] (The Deadmines)", instancePath,
    "partial exports must preserve authored dungeon links")
expect(instances[13], nil, "instanceIdToAreaId[13] (Test Dungeon)", instancePath,
    "deferred test/unused instance maps must remain absent")
expect(instances[35], nil, "instanceIdToAreaId[35] (unused Stormwind prison)", instancePath,
    "deferred test/unused instance maps must remain absent")

-- No-map dungeons still have instance and area identities, including their subareas.
for _, dungeon in ipairs(noMapDungeonIdentities) do
    local instance, area = dungeon.instance, dungeon.area
    expect(instances[instance], area, "instanceIdToAreaId[" .. instance .. "] for " .. areaLabel(area), instancePath,
        "a dungeon keeps its instance and area identity even without a UiMap")
    expect(nativeAreas[area], nil, "base areaIdToUiMapId[" .. area .. "] for " .. areaLabel(area), areaPath,
        "the reviewed dungeon has no native area route; 0 is not equivalent to absence")
    expect(areas[area], nil, "composed areaIdToUiMapId[" .. area .. "] for " .. areaLabel(area), areaPath,
        "this no-map dungeon must use its outdoor entrance, not compatibility or suppression")
end
for child, parent in pairs(dungeonChildParents) do
    expect(parents[child], parent, "subZoneToParentZone[" .. child .. "]", parentPath,
        "the dungeon subarea must retain its reviewed parent " .. areaLabel(parent))
end
expect(areas[17847], 2548, "areaIdToUiMapId[17847] (Twilight Hollow)", areaPath,
    "Twilight Hollow must retain its reviewed Riverglades route")
expect(parents[17847], 16591, "subZoneToParentZone[17847] (Twilight Hollow)", parentPath,
    "Twilight Hollow must retain Riverglades as its parent")

--------------------------------------------------------------------------------------------
-- NPC faction references: raw data, static writes and both faction branches
--------------------------------------------------------------------------------------------
-- Check actual references, not just whether two faction-table files have similar sizes.
local npcs = loader.loadEntityData("data/Forever/foreverNpcDB.lua", assert(config.entityTypeByName.Npc))
local factions = modules.QuestieDB.factionTemplate
---@param rows table<number, table>
---@param source string Current raw data or Correction paths to inspect.
local function checkFactionReferences(rows, source)
    for id, row in pairs(rows) do
        local faction = row[12]
        local name = row[1] or (npcs[id] and npcs[id][1]) or "Unnamed NPC"
        assert(faction == nil or factions[faction] ~= nil,
            "NPC " .. name .. " (" .. id .. ") factionID[12]: actual " .. tostring(faction)
            .. "; expected nil or an existing factionTemplate entry, actual factionTemplate[" .. tostring(faction)
            .. "] = " .. tostring(factions[faction]) .. ". A referenced faction template must exist. Inspect "
            .. factionPath .. " (factionTemplate) and " .. source)
    end
end
expect(factions[3546], nil, "factionTemplate[3546]", factionPath,
    "the removed DBC faction template must remain absent")
checkFactionReferences(npcs, "data/Forever/foreverNpcDB.lua (npcData)")
local ok, factionError = pcall(checkFactionReferences, missingFactionReference, "injected NPC 1 factionID[12] = 3546")
assert(not ok, "Faction-reference self-proof: expected an error rejecting NPC 1's missing faction template 3546; "
    .. "actual "
    .. (ok and "success (invalid reference accepted)" or ("error: " .. tostring(factionError)))
    .. ". Inspect checkFactionReferences in tools/dbc/forever-data.test.lua and " .. factionPath)

local lib = runtime.build()
local compat = lib.CorrectionCompat
local remove = compat.Install(config.flavorByName.Vanilla)
compat.BeginCapture()
runtime.execute("src/corrections/Forever/legacy/classicNPCFixes.lua", "QuestieDB", lib)
remove()
checkFactionReferences(compat.captured.Npc or {},
    "src/corrections/Forever/legacy/classicNPCFixes.lua (captured NPC Corrections)"
    .. " and data/Forever/foreverNpcDB.lua (npcData)")
for _, method in ipairs({"Load", "LoadFactionFixes"}) do
    for _, faction in ipairs({"Alliance", "Horde"}) do
        ---@return string
        UnitFactionGroup = function() return faction end
        ---@return string
        UnitClassBase = function() return "WARRIOR" end
        compat.BeginCapture()
        local provider = compat.modules.QuestieNPCFixes
        local source = "src/corrections/Forever/legacy/classicNPCFixes.lua (" .. method .. ", " .. faction .. ")"
        checkFactionReferences(compat.Invoke(provider[method], provider) or {},
            source .. " and data/Forever/foreverNpcDB.lua")
        checkFactionReferences(compat.captured.Npc or {},
            source .. " captured NPC Corrections and data/Forever/foreverNpcDB.lua")
    end
end
--------------------------------------------------------------------------------------------
-- Dungeon entrances: exact reviewed geometry and usable outdoor routes
--------------------------------------------------------------------------------------------
-- Correction capture borrows globals. Restore the support loader before reading dungeon data.
modules.Expansions = {
    Current = 1, -- Forever uses Classic dungeon rules for this support-data load.
    Wotlk = 3,
    Cata = 4,
}
installSupportLoader()
dofile(root .. "Zones/dungeons.lua")
local dungeons = private.dungeons
for area, dungeon in pairs(dungeons) do
    areaNames[area] = dungeon[1]
end
---@param point table?
local function entranceTriple(point)
    if not point then return "nil" end
    return "{" .. tostring(point[1]) .. ", " .. tostring(point[2]) .. ", " .. tostring(point[3]) .. "}"
end
for area, expected in pairs(expectedEntrances) do
    local actual = dungeons[area] and dungeons[area][4]
    expect(actual and #actual, #expected, "dungeons[" .. area .. "][4] entrance count for " .. areaLabel(area),
        dungeonPath, "the reviewed entrance list must keep every entrance")
    for index, point in ipairs(expected) do
        local actualPoint = actual[index]
        assert(actualPoint and actualPoint[1] == point[1] and actualPoint[2] == point[2] and actualPoint[3] == point[3],
            "dungeons[" .. area .. "][4][" .. index .. "] for " .. areaLabel(area) .. ", entrance point " .. index
            .. " in " .. areaLabel(point[1]) .. ": expected {AreaID, x, y} " .. entranceTriple(point)
            .. ", actual " .. entranceTriple(actualPoint)
            .. "; reviewed entrance coordinates must match exactly, without tolerance or a parent-area substitution. "
            .. "Inspect " .. dungeonPath)
    end
end
local entrances = {}
for area, dungeon in pairs(dungeons) do
    entrances[area] = dungeon[4]
end
for _, dungeon in pairs(dungeons) do
    for _, alias in ipairs(dungeon[2] or {}) do
        entrances[alias] = entrances[alias] or dungeon[4]
        areaNames[alias] = areaNames[alias] or dungeon[1]
    end
end

-- Dungeon markers need usable outdoor entrances, not a dungeon UiMap.
---@param area number
local function checkEntrance(area)
    assert(entrances[area], "dungeons entrance list for " .. areaLabel(area)
        .. ": expected an entrance list, actual " .. tostring(entrances[area])
        .. "; dungeon markers need outdoor entrances, including aliases in dungeons[area][2]. Inspect " .. dungeonPath)
    for index, entrance in ipairs(entrances[area]) do
        assert(areas[entrance[1]] and areas[entrance[1]] > 0,
            "Entrance map missing for " .. areaLabel(area) .. ", entrance point " .. index
            .. " " .. entranceTriple(entrance)
            .. " in " .. areaLabel(entrance[1]) .. ": expected areaIdToUiMapId[" .. entrance[1]
            .. "] > 0, actual " .. tostring(areas[entrance[1]])
            .. "; nil has no route and 0 suppresses display, so neither can route an outdoor entrance. Inspect "
            .. areaPath .. " (areaIdToUiMapId and areaIdToUiMapIdOverride) and "
            .. dungeonPath .. " (dungeons[area][4])")
        assert(entrance[2] >= 0 and entrance[3] >= 0,
            "dungeons entrance point " .. index .. " for " .. areaLabel(area) .. " in " .. areaLabel(entrance[1])
            .. ": expected x >= 0 and y >= 0, actual {AreaID, x, y} " .. entranceTriple(entrance)
            .. "; an entrance must be a drawable point, not instance presence {-1, -1}. Inspect " .. dungeonPath)
    end
end
local referenced = {}

-- Derive required routing from spawns, not the compatibility inventory under test.
---@param rows table<number, table>
---@param spawnField number
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

--------------------------------------------------------------------------------------------
-- Legacy-corrected NPC/object spawns and referenced compatibility
--------------------------------------------------------------------------------------------

-- Both entity types use the same capture mechanics; the chosen provider stays explicit here.
local function loadLegacyCorrectedEntities(entity)
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
    return rows
end

local correctedEntities = {}
for _, entity in ipairs(config.entityTypes) do
    if entity.name == "Npc" or entity.name == "Object" then
        local rows = loadLegacyCorrectedEntities(entity)
        checkSpawnEntrances(rows, entity.name == "Npc" and 7 or 4)
        correctedEntities[entity.name] = rows
    end
end
for area, map in pairs(forwardOverrides) do
    if map > 0 and area ~= 10073 and area ~= 10074 and area ~= 10089 then
        assert(referenced[area], "areaIdToUiMapIdOverride[" .. area .. "] for " .. areaLabel(area)
            .. ": actual UiMap " .. map .. ", current NPC/Object spawn reference " .. tostring(referenced[area])
            .. "; expected a current spawn reference for non-continent compatibility. "
            .. "Unused compatibility must not be retained. Inspect "
            .. areaPath .. "; current raw data data/Forever/foreverNpcDB.lua (npcData, spawns field 7),"
            .. " data/Forever/foreverObjectDB.lua (objectData, spawns field 4); Corrections"
            .. " src/corrections/Forever/legacy/classicNPCFixes.lua"
            .. " and src/corrections/Forever/legacy/classicObjectFixes.lua")
    end
end
--------------------------------------------------------------------------------------------
-- Representative quest objectives: follow targets to their corrected spawn routes
--------------------------------------------------------------------------------------------
local quests
for _, entity in ipairs(config.entityTypes) do
    if entity.name == "Quest" then
        quests = loader.loadEntityData("data/Forever/foreverQuestDB.lua", entity)
    end
end
for _, case in ipairs(representativeQuestObjectives) do
    local found = false
    for _, target in ipairs(quests[case.quest][10][case.objectiveField]) do
        if target[1] == case.target then
            local spawns = correctedEntities[case.entityType][target[1]][case.spawnField]
            assert(spawns[case.area], "Quest " .. quests[case.quest][1] .. " (" .. case.quest .. ") objective "
                .. case.entityType .. " " .. tostring(correctedEntities[case.entityType][target[1]][1])
                .. " (" .. target[1] .. ") spawns[" .. case.spawnField
                .. "]: expected alias " .. areaLabel(case.area) .. ", actual " .. tostring(spawns[case.area])
                .. "; the representative objective must keep its reviewed alias spawn. Inspect data/Forever/forever"
                .. case.entityType .. "DB.lua and src/corrections/Forever/legacy/"
                .. (case.entityType == "Npc" and "classicNPCFixes.lua" or "classicObjectFixes.lua"))
            for area, points in pairs(spawns) do
                for _, point in ipairs(points) do
                    assert(point[1] == -1 and point[2] == -1,
                        "Quest " .. case.quest .. " objective " .. case.entityType .. " " .. target[1]
                        .. " spawn in " .. areaLabel(area) .. ": expected instance presence {-1, -1}, actual {"
                        .. tostring(point[1]) .. ", " .. tostring(point[2])
                        .. "}; the reviewed objective uses instance presence, not a drawable point. "
                        .. "Inspect data/Forever/forever" .. case.entityType .. "DB.lua (spawns["
                        .. case.spawnField .. "]) and src/corrections/Forever/legacy/"
                        .. (case.entityType == "Npc" and "classicNPCFixes.lua" or "classicObjectFixes.lua"))
                end
                checkEntrance(area)
            end
            found = true
        end
    end
    assert(found, "Quest " .. quests[case.quest][1] .. " (" .. case.quest .. ") objectives[10][" .. case.objectiveField
        .. "]: expected " .. case.entityType .. " " .. case.target
        .. ", actual matching objective found = " .. tostring(found)
        .. "; the reviewed quest-to-entity reference must remain intact. "
        .. "Inspect data/Forever/foreverQuestDB.lua (questData)")
end
--------------------------------------------------------------------------------------------
-- Missing-route controls: markers pass without a dungeon map; bad outdoor routes fail
--------------------------------------------------------------------------------------------
-- The temporary omissions below exercise the same scanners as the real-data checks.
local validateSpawnArea = zoneValidation.BuildSpawnAreaValidator(function(area) return areas[area] end, dungeons)
for _, area in ipairs(entranceFixtures) do
    local saved = areas[area]
    areas[area] = nil
    checkSpawnEntrances(correctedEntities.Npc, 7)
    local markerOk, markerError = validateSpawnArea(area, {{-1, -1}})
    assert(markerOk, "Dungeon entrance routing for " .. areaLabel(area)
        .. ": expected acceptance of instance presence {-1, -1} with areaIdToUiMapId[" .. area .. "] = nil, actual "
        .. tostring(markerOk) .. " (" .. tostring(markerError)
        .. "); outdoor entrances must route no-map dungeon markers. Inspect "
        .. dungeonPath .. ", " .. areaPath .. " and validators/zones.lua (BuildSpawnAreaValidator)")
    local pointOk, pointError = validateSpawnArea(area, {{10, 20}})
    assert(not pointOk, "Unmapped ordinary coordinates for " .. areaLabel(area)
        .. ": expected rejection of {10, 20} with areaIdToUiMapId[" .. area .. "] = nil, actual "
        .. tostring(pointOk) .. " (" .. tostring(pointError)
        .. "); an outdoor entrance cannot establish a coordinate frame for a point inside the dungeon. "
        .. "Inspect validators/zones.lua (BuildSpawnAreaValidator), " .. areaPath .. " and " .. dungeonPath)
    areas[area] = saved
end
local dungeonArea, entranceArea = missingEntranceMap.dungeonArea, missingEntranceMap.entranceArea
local savedMap, savedCompatibility = areas[entranceArea], areas[dungeonArea]
areas[entranceArea], areas[dungeonArea] = nil, nil
local missingMapOk, missingMapError = validateSpawnArea(dungeonArea, {{-1, -1}})
assert(not missingMapOk, "Missing entrance map detection for Dire Maul (area 10022), entrance in Feralas (area 357):"
    .. " expected rejection of {-1, -1} after removing both area routes, actual " .. tostring(missingMapOk)
    .. " (" .. tostring(missingMapError) .. "); instance presence cannot route through an unmapped entrance. Inspect "
    .. "validators/zones.lua (BuildSpawnAreaValidator), " .. areaPath .. " and " .. dungeonPath)
local entranceOk, entranceError = pcall(checkEntrance, dungeonArea)
areas[entranceArea], areas[dungeonArea] = savedMap, savedCompatibility
assert(not entranceOk, "Missing entrance map self-proof for Dire Maul (area 10022), "
    .. "entrance point 1 in Feralas (area 357):"
    .. " expected an error when areaIdToUiMapId[357] and [10022] are nil; actual "
    .. (entranceOk and "success (unmapped entrance accepted)" or ("error: " .. tostring(entranceError)))
    .. ". Inspect checkEntrance in tools/dbc/forever-data.test.lua, " .. areaPath .. " and " .. dungeonPath)
checkEntrance(10022)
checkEntrance(10032)
print("Forever support shapes, DBC links, entrance compatibility and faction references passed (including self-proofs)")
