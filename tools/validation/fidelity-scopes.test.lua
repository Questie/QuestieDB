-- Exercise the real fidelity runners' file selection without a migration checkout.
local load = dofile
local lib = load("generator/lib.lua")
local config = load("src/config.lua")
local flavor = config.flavorByName.Wrath
local originalRead, originalExists = lib.readAll, lib.fileExists
local reads = {}
local artifact = "QuestieDB_Wrath.toc"
local selected = false

-- Unrelated TOCs deliberately exist but contain an invalid file list. Neither shared
-- checks nor the Wrath artifact checks may discover or read them.
---@param path string
---@return string
lib.readAll = function(path)
  if path:match("^QuestieDB_.+%.toc$") then
    assert(selected and path == artifact, "unexpected artifact read: " .. path)
    reads[#reads + 1] = path
    return "fixture.lua\n"
  end
  if path == "QuestieDB.toc" or path:match("oracle/Questie%-.+%.toc$") then return "" end
  if path == "oracle/Database/DropTables/dropDB.lua" then return "DropDB.correctionKeys = {}" end
  return originalRead(path)
end
---@param path string
---@return boolean
lib.fileExists = function(path)
  assert(not path:match("^QuestieDB_.+%.toc$"), "artifact discovery: " .. path)
  return originalExists(path)
end
lib.assertQuestiePin = function() end
config.sourceFileList = function() return {} end
config.bakedFileList = function() return {} end
config.supportData = { shared = {}, perFlavor = {} }
for _, entry in ipairs(config.flavors) do config.supportData.perFlavor[entry.name] = {} end

---@param path string
---@return any
_G.dofile = function(path)
  if path == "generator/lib.lua" then return lib end
  if path == "src/config.lua" then return config end
  if path == "tools/questie-sync/support-inventory.lua" then return {} end
  return load(path)
end
local objective = load("tools/questie-sync/objective-first.lua")
local support = load("tools/questie-sync/support-fidelity.lua")
_G.dofile = load

-- Comparison contents are covered by the fidelity suites. These small providers isolate
-- the selection contract while still executing each real runner and all its persona loops.
objective.loadOracle = function() return {}, {} end
objective.loadProvider = function() return {} end
local modules = { ZoneDB = { zoneIDs = { THE_RING_OF_TRIALS = 9999 },
  private = { dungeons = { [2257] = { "Deeprun Tram" } } } } }
support.loadInputs = function() return modules end
support.loadProvider = function() return modules end

local messages = {}
---@param condition boolean
---@param message string
local function check(condition, message)
  assert(condition, message)
  messages[#messages + 1] = message
end
objective.run(check, "oracle")
support.run(check, "oracle")
assert(#reads == 0, "shared fidelity must not read generated TOCs")

selected = true
messages = {}
objective.run(check, "oracle", nil, flavor)
assert(#messages == 3, "Wrath emitted hints must cover plain Wrath, Titan, and unsupported SoD")
assert(messages[1]:find("Wrath emitted Baked", 1, true))
assert(messages[2]:find("Titan emitted Baked", 1, true))
assert(messages[3]:find("Wrath SoD emitted Baked", 1, true))
support.run(check, "oracle", flavor)
assert(#messages == 7, "Wrath support must check both factions and dungeon shapes")
assert(#reads == 5, "each emitted persona/faction must read the selected TOC")
print("fidelity scope routing passed")
