-- Actual Lua loading checks the candidate against owned data plus an independent reviewed set.
---@param path string
---@return table<integer, integer> base
---@return table<integer, integer> overrides
local function loadParents(path)
    ---@type table
    local zone = { private = {} }
    ---@type table
    local environment = {
        QuestieLoader = {
            ---@param _ table
            ---@param name string
            ---@return table
            ImportModule = function(_, name)
                assert(name == "ZoneDB")
                return zone
            end,
        },
    }
    setfenv(assert(loadfile(path)), environment)()
    assert(type(zone.private.subZoneToParentZone) == "string")
    assert(type(zone.private.subZoneToParentZoneOverride) == "string")
    return assert(loadstring(zone.private.subZoneToParentZone))(),
        assert(loadstring(zone.private.subZoneToParentZoneOverride))()
end

local candidate, candidateOverrides = loadParents(assert(arg[1]))
local original, originalOverrides = loadParents(assert(arg[2]))
local reviewed = assert(loadfile(assert(arg[3])))()
for area, parent in pairs(original) do
    assert(candidate[area] == parent, "Authored base changed at " .. area)
end
for area, parent in pairs(originalOverrides) do
    assert(candidateOverrides[area] == parent, "Authored override changed at " .. area)
end
for area in pairs(candidateOverrides) do
    assert(originalOverrides[area] ~= nil, "Unexpected override at " .. area)
end
for area, parent in pairs(reviewed) do
    assert((candidateOverrides[area] or candidate[area]) == parent, "Reviewed parent differs at " .. area)
end
for area, parent in pairs(candidate) do
    assert(original[area] == parent or reviewed[area] == parent, "Unexpected parent at " .. area)
end
print("Authored parents preserved; reviewed relationships match")
