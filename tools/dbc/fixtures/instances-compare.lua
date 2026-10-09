-- Load symbolic identities through the owned enum contract, not a flattened test table.
local constants = {}
assert(loadfile(assert(arg[3])))(nil, { Enum = constants })

local function loadInstances(path)
    local zone = { zoneIDs = constants.zoneIDs }
    local environment = {
        QuestieLoader = {
            ImportModule = function(_, name)
                assert(name == "ZoneDB")
                return zone
            end,
        },
    }
    setfenv(assert(loadfile(path)), environment)()
    return assert(zone.instanceIdToAreaId)
end

local candidate = loadInstances(assert(arg[1]))
local original = loadInstances(assert(arg[2]))
local expected = assert(loadfile(assert(arg[4])))()
for map, area in pairs(original) do
    assert(candidate[map] == area, "Authored instance changed at " .. map)
end
for map, area in pairs(expected) do
    assert(candidate[map] == area, "Expected instance differs at " .. map)
end
for map, area in pairs(candidate) do
    assert(original[map] == area or expected[map] == area, "Unexpected instance at " .. map)
end
print("Authored instances preserved; expected additions match")
