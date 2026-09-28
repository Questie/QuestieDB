-- Remove centrally declared Static exports from staged Baked providers only.
-- Source formatting contract: `function providers.Name()` and its closing `end`
-- start at column zero; nested blocks are indented. Ambiguity aborts packaging.
-- Dynamic exports, shared helpers and load-time hints remain byte-identical.
-- Behavior is checked through the native registrar, never a replacement loader.
local lib = dofile("generator/lib.lua")
local runtime = dofile("generator/runtime.lua")
local client = dofile("emulator/client.lua")
local config = dofile("src/config.lua")
local manifest = dofile("src/corrections/manifest.lua")

local stagedDir = assert(arg[1], "usage: strip-static.lua <stagedAddonDir> [--quiet]")
assert(arg[2] == nil or arg[2] == "--quiet", "unknown strip-static option")
assert(arg[3] == nil, "unexpected strip-static argument")

---Remove a complete export, not a callable Static stub.
---@param content string
---@param method string
---@param path string
---@return string
local function stripFunction(content, method, path)
  local lines = {}
  for line in (content .. "\n"):gmatch("([^\n]*)\n") do lines[#lines + 1] = line end
  assert(table.concat(lines, "\n") == content, path .. ": lossless line split failed")
  local first, last
  for index, line in ipairs(lines) do
    if line:match("^function providers%." .. method .. "%(%)[ \r]*$") then
      assert(not first, path .. ": duplicate Static definition " .. method)
      first = index
    end
  end
  assert(first, path .. ": Static function not found at column zero: " .. method)
  for index = first + 1, #lines do
    local line = lines[index]
    assert(not line:match("^function "), path .. ": missing column-zero end for " .. method)
    if line:match("^end[ \r]*$") then last = index; break end
  end
  assert(last, path .. ": missing closing end for " .. method)
  -- The source annotation belongs to the removed declaration, not the next shared helper.
  while first > 1 and lines[first - 1]:match("^%-%-%-@") do first = first - 1 end
  for _ = first, last do table.remove(lines, first) end
  return table.concat(lines, "\n")
end

---@param value any
---@return any
local function copy(value)
  if type(value) ~= "table" then return value end
  local result = {}
  for key, child in pairs(value) do result[key] = copy(child) end
  return result
end

---Observe exactly what Baked consumes, including central registration metadata and hints.
---The manifest classifies each exported function; the staged file inventory only decides
---whether this provider is present in the package.
---@param spec CorrectionFileSpec
---@param content string
---@param flavor table
---@param stripped boolean
---@return table
local function observe(spec, content, flavor, stripped)
  local db = runtime.build()
  db.flavor, db.mode = flavor, "baked"
  runtime.execute("src/corrections/prepare.lua", "QuestieDB", db)
  db.CorrectionManifest = { spec }
  assert(loadstring(content, "@" .. spec.file))("QuestieDB", db)
  assert(#db.Corrections.Select({}) == 0, spec.file .. ": provider registered outside central policy")
  for provider in pairs(db.CorrectionProviders) do
    assert(provider == spec.provider, spec.file .. ": unexpected export table " .. provider)
  end
  if stripped then
    local exports = db.CorrectionProviders[spec.provider]
    for _, declaration in ipairs(spec.functions) do
      if declaration.category == "static" and exports then
        assert(exports[declaration.method] == nil, spec.file .. ": Static export survived stripping")
      end
    end
  end
  runtime.execute("src/corrections/register.lua", "QuestieDB", db)

  -- Capture true native Dynamic registrations and outputs, not a packaging-only persona.
  local observed = { before = copy(db.ObjectiveFirst), entries = {}, outputs = {} }
  for _, entry in ipairs(db.Corrections.Select({})) do
    assert(entry.dynamic, spec.file .. ": Baked registered a Static function")
    local metadata = {}
    for key, value in pairs(entry) do
      if key ~= "func" then metadata[key] = copy(value) end
    end
    observed.entries[#observed.entries + 1] = metadata
    observed.outputs[entry.name] = copy(entry.func())
  end
  observed.after = copy(db.ObjectiveFirst)
  return observed
end

local classes = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT",
  "SHAMAN", "MAGE", "WARLOCK", "MONK", "DRUID" }

---Cover every applicable constant shape and the providers' faction/class/race branches.
---@param spec CorrectionFileSpec
---@param original string
---@param stripped string
---@return nil
local function assertParity(spec, original, stripped)
  local checks = 0
  for _, flavor in ipairs(config.flavors) do
    if config.correctionApplies(spec, flavor) then
      local seasons = spec.season and { "None", spec.season } or { "None" }
      for _, season in ipairs(seasons) do
        for _, faction in ipairs({ "Alliance", "Horde" }) do
          for classId, class in ipairs(classes) do
            for _, race in ipairs({ "Human", "Orc" }) do
              client.reset()
              client.install({ expansion = flavor.expansion, season = season, faction = faction,
                classFile = class, classId = classId, raceName = race, raceFile = race,
                raceId = race == "Human" and 1 or 2 })
              local before = observe(spec, original, flavor, false)
              local after = observe(spec, stripped, flavor, true)
              assert(lib.deepEqual(before, after), spec.file .. ": Baked behavior changed after stripping: "
                .. flavor.name .. "/" .. season .. "/" .. faction .. "/" .. class .. "/" .. race)
              checks = checks + 1
            end
          end
        end
      end
    end
  end
  client.reset()
  assert(checks > 0, spec.file .. ": no applicable strip personas")
end

-- Phase 1: collect and validate every transformation before writing any staged file.
-- Repository originals remain the behavior baseline and are never modified.
local pending, beforeBytes, afterBytes = {}, 0, 0
for _, spec in ipairs(manifest) do
  local path = stagedDir .. "/src/corrections/" .. spec.file
  if lib.fileExists(path) then
    local methods = {}
    for _, declaration in ipairs(spec.functions) do
      assert(declaration.category == "static" or declaration.category == "dynamic", "invalid category: " .. spec.file)
      if declaration.category == "static" then methods[#methods + 1] = declaration.method end
    end
    if #methods > 0 then
      assert(config.hasDynamicCorrections(spec), "Static-only provider in Baked package: " .. spec.file)
      local sourcePath = "src/corrections/" .. spec.file
      local original = lib.readAll(sourcePath)
      assert(lib.readAll(path) == original, path .. ": staged bytes differ before stripping")
      assert(loadstring(original, "@" .. sourcePath))
      local stripped = original
      for _, method in ipairs(methods) do stripped = stripFunction(stripped, method, spec.file) end
      assert(loadstring(stripped, "@" .. path))
      assertParity(spec, original, stripped)
      pending[#pending + 1] = { path = path, content = stripped }
      beforeBytes, afterBytes = beforeBytes + #original, afterBytes + #stripped
    end
  end
end

-- Phase 2: publish only after every transformed provider passes syntax and native parity.
for _, file in ipairs(pending) do lib.writeAll(file.path, file.content) end
if arg[2] ~= "--quiet" then
  print(("strip-static: %d files, %d -> %d bytes (native behavior checked)"):format(#pending, beforeBytes, afterBytes))
end
