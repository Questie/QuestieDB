-- Semantic verification for the offline Forever converter. Run from the repository root.
-- The plan and Lua inputs are trusted local files; this is not an execution sandbox.
-- Providers load through QuestieDB's native runtime and central registrar, not a Questie
-- compatibility loader.

local loader = dofile("generator/loader.lua")
local runtime = dofile("generator/runtime.lua")
local config = dofile("src/config.lua")

---@class ConversionCoefficients
---@field scale_x number
---@field offset_x number
---@field scale_y number
---@field offset_y number

---@class ConversionFile
---@field source string
---@field output string
---@field target string? Manifest path for the staged output.
---@field entity string
---@field raw boolean
---@field categories string[]?
---@field registrations string[]?
---@field sourceSpec string? Manifest path when source is a fixture.

---@class ConversionPlan
---@field files ConversionFile[]
---@field transforms table<number, ConversionCoefficients>

---@type ConversionPlan
local plan = assert(loadfile(assert(arg[1], "Expected validation-plan.lua path")))()
assert(type(plan.files) == "table" and type(plan.transforms) == "table", "Invalid conversion plan")

-- Resolve schema once. Raw files use it for semantic loading; provider files use their
-- explicit plan entity to verify central registration datatypes.
---@type table<string, table>
local entityTypes = {}
for _, entity in ipairs(config.entityTypes) do entityTypes[entity.name] = entity end

---Copy registration metadata without retaining provider-owned tables.
---@param value any
---@return any
local function copy(value)
    if type(value) ~= "table" then return value end
    local result = {}
    for key, child in pairs(value) do result[key] = copy(child) end
    return result
end

---Only marked coordinate slots may differ by floating-point evaluation tolerance.
---@param expected any
---@param actual any
---@param path string
---@param coordinates table<table, boolean>?
---@param approximate boolean?
---@return nil
local function compare(expected, actual, path, coordinates, approximate)
    if type(expected) ~= type(actual) then error(path .. ": value type differs", 0) end
    if type(expected) ~= "table" then
        if approximate and type(expected) == "number" then
            if expected == actual or math.abs(expected - actual) <= 1e-10 then return end
        elseif expected == actual then
            return
        end
        error(path .. ": expected " .. tostring(expected) .. ", got " .. tostring(actual), 0)
    end
    for key, value in pairs(expected) do
        compare(value, actual[key], path .. "[" .. tostring(key) .. "]", coordinates,
            coordinates and coordinates[expected] and (key == 1 or key == 2))
    end
    for key in pairs(actual) do
        if expected[key] == nil then error(path .. ": unexpected key " .. tostring(key), 0) end
    end
end

---Match the offline output policy, independently of the Python rewriter.
---@param value number
---@return number
local function roundCoordinate(value)
    local rounded = math.floor(math.abs(value) * 100 + 0.5) / 100
    return value < 0 and -rounded or rounded
end

---Apply expected geometry only to schema-designated coordinate structures.
---@param rows table?
---@param entity string
---@return table<table, boolean> coordinates
local function transformRows(rows, entity)
    local coordinates = {}
    if rows == nil then return coordinates end
    assert(type(rows) == "table", "Provider must return a table or nil")

    ---@param pair table
    ---@param area number
    ---@return nil
    local function point(pair, area)
        assert(type(pair) == "table" and type(pair[1]) == "number" and type(pair[2]) == "number",
            "Malformed coordinate tuple")
        if coordinates[pair] then return end
        coordinates[pair] = true
        local x, y = pair[1], pair[2]
        if x == -1 or y == -1 then
            assert(x == -1 and y == -1, "Partial instance sentinel")
            return
        end
        local transform = plan.transforms[area]
        if transform then
            local newX = transform.scale_x * x + transform.offset_x
            local newY = transform.scale_y * y + transform.offset_y
            if newX ~= x or newY ~= y then
                pair[1], pair[2] = roundCoordinate(newX), roundCoordinate(newY)
                assert(pair[1] ~= -1 and pair[2] ~= -1, "Rounding would create an instance sentinel")
            end
        end
    end

    ---@param groups table?
    ---@param waypoints boolean?
    ---@return nil
    local function locations(groups, waypoints)
        if groups == nil then return end
        for area, entries in pairs(groups) do
            for _, entry in pairs(entries) do
                if waypoints and type(entry[1]) == "table" then
                    for _, pair in pairs(entry) do point(pair, area) end
                elseif waypoints and next(entry) == nil then
                    -- An empty path has no points, just as an empty waypoint field does.
                else
                    point(entry, area)
                end
            end
        end
    end

    for _, row in pairs(rows) do
        if entity == "Npc" then
            locations(row[7])
            locations(row[8], true)
        elseif entity == "Object" then
            locations(row[4])
            locations(row[7], true)
        elseif entity == "Quest" then
            if row[9] then locations(row[9][2]) end
            if row[29] then
                for _, objective in pairs(row[29]) do locations(objective[1]) end
            end
        elseif entity ~= "Item" then
            error("Unknown entity type " .. tostring(entity), 0)
        end
    end
    return coordinates
end

---Validate native exports against the real central policy, then compose that one file.
---`manifestPath` identifies the file declaration; its `functions` list owns categories,
---ordering, options, and stable registration names.
---@param path string
---@param manifestPath string
---@param flavorName string
---@return table
local function loadCorrection(path, manifestPath, flavorName)
    local lib = runtime.build()
    -- Compare code under the destination's constants: conversion changes coordinates, not
    -- symbolic race references. Era and Forever intentionally have different faction masks.
    lib.flavor = config.flavorByName.Forever
    runtime.execute("src/corrections/prepare.lua", "QuestieDB", lib)
    -- Still validate each file against its own applicability and registration metadata.
    lib.flavor = config.flavorByName[flavorName]
    local selected
    for _, spec in ipairs(lib.CorrectionManifest) do
        if "src/corrections/" .. spec.file == manifestPath then selected = spec end
    end
    assert(selected, "Missing correction manifest entry: " .. manifestPath)
    assert(config.correctionApplies(selected, lib.flavor), "Inapplicable conversion provider: " .. manifestPath)
    lib.CorrectionManifest = { selected }
    runtime.execute(path, "QuestieDB", lib)
    assert(#lib.Corrections.Select({}) == 0, "Provider must not register corrections directly")
    for provider in pairs(lib.CorrectionProviders) do
        assert(provider == selected.provider, "Unexpected correction export: " .. provider)
    end
    runtime.execute("src/corrections/register.lua", "QuestieDB", lib)
    return lib
end

local client = dofile("emulator/client.lua")
local classes = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT",
    "SHAMAN", "MAGE", "WARLOCK", "MONK", "DRUID" }

---Compare complete registration metadata, permitting only the explicit ownership retarget.
---@param entry table
---@param target boolean
---@return table
local function metadata(entry, target)
    local result = {}
    for key, value in pairs(entry) do
        if key ~= "func" then result[key] = copy(value) end
    end
    if not target then
        result.name = "Forever/legacy/" .. assert(result.name:match("^[^/]+/(.+)$"))
        if entry.name == "Era/classicQuestReputationFixes.lua:Load" then
            result.expansions = { Forever = true }
        end
    end
    return result
end

local providerChecks = 0
for _, file in ipairs(plan.files) do
    assert(entityTypes[file.entity], "Invalid entity type in plan")
    if file.raw then
        -- Raw baseline: only schema-designated coordinates may differ.
        local expected, sourceKeys = loader.loadEntityData(file.source, entityTypes[file.entity])
        local actual, outputKeys = loader.loadEntityData(file.output, entityTypes[file.entity])
        compare(sourceKeys, outputKeys, file.output .. ": keys")
        local coordinates = transformRows(expected, file.entity)
        compare(expected, actual, file.output, coordinates)
    else
        -- Native provider baseline: exercise all faction/class/race branches against the
        -- source and destination manifest declarations. This proves behavior, not byte shape.
        for _, faction in ipairs({ "Alliance", "Horde" }) do
            for classId, class in ipairs(classes) do
                for _, race in ipairs({ "Human", "Orc" }) do
                    client.reset()
                    client.install({ expansion = "Classic", faction = faction, classFile = class, classId = classId,
                        raceName = race, raceFile = race, raceId = race == "Human" and 1 or 2 })
                    local source = loadCorrection(file.source, file.sourceSpec or file.source, "Vanilla")
                    local target = loadCorrection(file.output, assert(file.target, "Missing target manifest path"), "Forever")

                    -- Registration inventory and metadata must match before invoking providers.
                    local expectedEntries = source.Corrections.Select({})
                    local actualEntries = target.Corrections.Select({})
                    assert(#expectedEntries == #file.registrations, "Unlisted source registration")
                    assert(#actualEntries == #expectedEntries, "Output registration inventory differs")
                    compare(source.ObjectiveFirst, target.ObjectiveFirst, file.output .. ": load-time hints")
                    for index, identity in ipairs(file.registrations) do
                        local expected, actual = expectedEntries[index], actualEntries[index]
                        assert(expected.name == identity, "Unexpected source registration: " .. expected.name)
                        assert(expected.datatype == file.entity, "Unexpected source datatype")
                        assert(expected.dynamic == (file.categories[index] == "dynamic"), "Unexpected source category")
                        local path = file.output .. ": " .. identity .. "/" .. faction .. "/" .. class .. "/" .. race
                        compare(metadata(expected, false), metadata(actual, true), path .. ": registration")

                        -- Provider rows may differ only at transformed coordinate slots; hints
                        -- must remain stable both before and after provider invocation.
                        local expectedRows, actualRows = expected.func(), actual.func()
                        local coordinates = transformRows(expectedRows, file.entity)
                        compare(expectedRows, actualRows, path, coordinates)
                        compare(source.ObjectiveFirst, target.ObjectiveFirst, path .. ": hints")
                        providerChecks = providerChecks + 1
                    end
                end
            end
        end
        client.reset()
    end
end
print("Validated " .. #plan.files .. " converted files and " .. providerChecks .. " correction personas")
