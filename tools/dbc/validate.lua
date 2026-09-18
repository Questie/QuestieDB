-- Semantic verification for the offline Forever converter. Run from the repository root.
-- The plan and Lua inputs are trusted local files; this is not an execution sandbox.

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
---@field entity string
---@field raw boolean
---@field module string?
---@field methods string[]?

---@class ConversionPlan
---@field files ConversionFile[]
---@field transforms table<number, ConversionCoefficients>

---@type ConversionPlan
local plan = assert(loadfile(assert(arg[1], "Expected validation-plan.lua path")))()
assert(type(plan.files) == "table" and type(plan.transforms) == "table", "Invalid conversion plan")

---@type table<string, table>
local entityTypes = {}
for _, entity in ipairs(config.entityTypes) do entityTypes[entity.name] = entity end

---Copy results before another provider invocation clears captured buffers.
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

---Load an isolated copy of a correction module through the actual provider shim.
---@param path string
---@param moduleName string
---@return table context
local function loadCorrection(path, moduleName)
    local lib = runtime.build()
    local compat = lib.CorrectionCompat
    local remove = compat.Install(config.flavorByName.Vanilla)
    compat.BeginCapture()
    local ok, message = pcall(runtime.execute, path, "QuestieDB", lib)
    remove()
    if not ok then error(message, 0) end
    local module = assert(compat.modules[moduleName], "Missing correction module " .. moduleName)
    return {
        compat = compat,
        module = module,
        hints = copy(compat.objectiveFirst),
        captured = copy(compat.captured),
    }
end

---Compare all capture types, including direct writes outside the declared provider type.
---@param expected table
---@param actual table
---@param path string
---@return nil
local function compareCaptures(expected, actual, path)
    for _, entity in ipairs(config.entityTypes) do
        local coordinates = transformRows(expected[entity.name], entity.name)
        compare(expected[entity.name], actual[entity.name], path .. "." .. entity.name, coordinates)
    end
end

---@type string[]
local classes = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
local providerChecks = 0
for _, file in ipairs(plan.files) do
    assert(entityTypes[file.entity], "Invalid entity type in plan")
    if file.raw then
        local expected, sourceKeys = loader.loadEntityData(file.source, entityTypes[file.entity])
        local actual, outputKeys = loader.loadEntityData(file.output, entityTypes[file.entity])
        compare(sourceKeys, outputKeys, file.output .. ": keys")
        local coordinates = transformRows(expected, file.entity)
        compare(expected, actual, file.output, coordinates)
    else
        local source = loadCorrection(file.source, assert(file.module))
        local target = loadCorrection(file.output, file.module)
        compare(source.hints, target.hints, file.output .. ": load-time objective hints")
        compareCaptures(source.captured, target.captured, file.output .. ": load-time captures")

        local methods = {}
        for _, method in ipairs(assert(file.methods)) do methods[method] = true end
        -- A forgotten provider must not disappear from validation merely because the plan omitted it.
        for name, value in pairs(source.module) do
            if type(value) == "function" then
                assert(methods[name], "Unlisted correction method " .. file.module .. "." .. name)
                assert(type(target.module[name]) == "function", "Missing output correction method " .. name)
            else
                compare(value, target.module[name], file.output .. ": module field " .. name)
            end
        end
        for name in pairs(target.module) do
            assert(source.module[name] ~= nil, "Unexpected output module field " .. name)
        end

        for _, method in ipairs(file.methods) do
            local personas = { { faction = "Alliance", class = "WARRIOR" } }
            if method == "LoadFactionFixes" then
                personas = {}
                for _, faction in ipairs({ "Alliance", "Horde" }) do
                    local selectedClasses = file.entity == "Quest" and classes or { "WARRIOR" }
                    for _, class in ipairs(selectedClasses) do
                        personas[#personas + 1] = { faction = faction, class = class }
                    end
                end
            end
            for _, persona in ipairs(personas) do
                ---@param _ string
                ---@return string
                UnitFactionGroup = function(_) return persona.faction end
                ---@param _ string
                ---@return string
                UnitClassBase = function(_) return persona.class end
                source.compat.BeginCapture()
                target.compat.BeginCapture()
                local expected = source.compat.Invoke(assert(source.module[method]), source.module)
                local actual = target.compat.Invoke(assert(target.module[method]), target.module)
                local sourceCaptured = copy(source.compat.captured)
                local path = file.output .. ": " .. method .. "/" .. persona.faction .. "/" .. persona.class
                local coordinates = transformRows(expected, file.entity)
                compare(expected, actual, path, coordinates)
                compareCaptures(sourceCaptured, target.compat.captured, path .. ": captures")
                compare(source.compat.objectiveFirst, target.compat.objectiveFirst, path .. ": hints")
                providerChecks = providerChecks + 1
            end
        end
    end
end
print("Validated " .. #plan.files .. " converted files and " .. providerChecks .. " correction personas")
