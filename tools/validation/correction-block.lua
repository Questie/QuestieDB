-- Isolated correction-block loading for ObjectiveFirst lifecycle tests.
local lib = dofile("generator/lib.lua")
local config = dofile("src/config.lua")
config.correctionManifest = dofile("src/corrections/manifest.lua")
local fixture = {}

---@param path string
---@return string[] files
function fixture.tocFiles(path)
  local files = {}
  for line in lib.readAll(path):gmatch("[^\r\n]+") do
    line = line:gsub("\\", "/"):gsub("^%s+", ""):gsub("%s+$", "")
    if line:match("%.lua$") and not line:match("^#") then files[#files + 1] = line end
  end
  return files
end

---@param source string
---@param label string
---@param env table
---@param namespace table?
---@return nil
local function execute(source, label, env, namespace)
  local chunk = assert(loadstring(source, "@" .. label))
  setfenv(chunk, env)
  chunk("QuestieDB", namespace)
end

---Load the actual correction block without unrelated entity payloads or derived passes.
---The isolated environment also makes sequential persona loads independent of process globals.
---@param files string[] Configured or emitted TOC files.
---@param flavorName string
---@param seasonId number
---@param mode string
---@param root string? Alternate staged addon directory.
---@return table hints
---@return table namespace
---@return table environment Isolated client globals, for load-boundary controls.
function fixture.loadProvider(files, flavorName, seasonId, mode, root)
  local previousLoader = {}
  local env = setmetatable({ QuestieLoader = previousLoader }, { __index = _G })
  env._G = env
  env.C_Seasons = { GetActiveSeason = function() return seasonId end }
  env.Enum = { SeasonID = { SeasonOfDiscovery = 2 } }
  local namespace = { config = config, flavor = assert(config.flavorByName[flavorName]), mode = mode }
  -- Authored corrections can resolve field keys at registration time. Load the real schema
  -- before the registry, as both addon TOCs do, without loading any entity payloads.
  for _, file in ipairs(files) do
    if file:match("^src/meta/") then
      execute(lib.readAll((root or ".") .. "/" .. file), file, env, namespace)
    end
  end
  execute(lib.readAll((root or ".") .. "/src/corrections/registry.lua"), "registry.lua", env, namespace)
  for _, file in ipairs(files) do
    if file:match("^src/corrections/") and file ~= "src/corrections/registry.lua" then
      execute(lib.readAll((root or ".") .. "/" .. file), file, env, namespace)
    end
  end
  assert(env.QuestieLoader == previousLoader, "correction loader was not restored")
  assert(namespace.ObjectiveFirst, "correction block did not publish ObjectiveFirst")
  return namespace.ObjectiveFirst, namespace, env
end

return fixture
