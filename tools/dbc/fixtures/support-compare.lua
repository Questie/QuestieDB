-- Compare actual deferred Lua values, not regex counts or generated expectations.
---@param directory string
---@return table<string, table<integer, integer>>
local function loadMappings(directory)
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
    setmetatable(environment, { __index = _G })
    setfenv(assert(loadfile(directory .. "/areaIdToUiMapId.lua")), environment)()
    setfenv(assert(loadfile(directory .. "/uiMapIdToAreaId.lua")), environment)()
    ---@type table<string, table<integer, integer>>
    local tables = {}
    for _, name in ipairs({"areaIdToUiMapId", "areaIdToUiMapIdOverride", "uiMapIdToAreaId", "uiMapIdToAreaIdOverride"}) do
        assert(type(zone.private[name]) == "string", name .. " must remain deferred Lua")
        tables[name] = assert(loadstring(zone.private[name]))()
    end
    return tables
end

local candidate = loadMappings(assert(arg[1]))
local expected = loadMappings(assert(arg[2]))
local historicalSubset = arg[3] == "--historical-subset"
assert(arg[3] == nil or historicalSubset, "Unknown comparison mode")
for name, values in pairs(expected) do
    -- Historical snapshots need not contain later base additions. Authored policy
    -- still matches exactly; ordinary candidate adoption requires exact tables.
    local allowLaterRows = historicalSubset and not name:find("Override$")
    for key, value in pairs(values) do
        if not allowLaterRows or candidate[name][key] ~= nil then
            assert(candidate[name][key] == value, name .. " differs at " .. key)
        end
    end
    for key, value in pairs(candidate[name]) do
        assert(values[key] == value, name .. " unexpected or differing key " .. key)
    end
end
print("All four mapping tables match" .. (historicalSubset and " (historical base subset)" or ""))
