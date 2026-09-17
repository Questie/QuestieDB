-- Independent migration oracle for imported translations and their authored corrections.
-- It executes pinned Questie inputs directly, without the generator's import inventory,
-- field adapter, or static-correction merge. Entity IDs come from the generation dataset;
-- entity-input fidelity is enforced separately by the repository's existing gates.
local config = dofile("src/config.lua")
local lib = dofile("generator/lib.lua")

local fidelity = {}

---@param locale string
---@return table env
---@return table modules
local function environment(locale)
  local symbols = setmetatable({}, { __index = function(_, name) return name end })
  local modules = {
    l10n = { questLookup = {}, itemLookup = {}, npcNameLookup = {}, objectLookup = {} },
    QuestieDB = { questKeys = symbols },
  }
  local env = setmetatable({ Questie = {} }, { __index = _G })
  env._G = env
  env.GetLocale = function() return locale end
  env.QuestieLoader = {
    ImportModule = function(_, name) return assert(modules[name], name) end,
    CreateModule = function(_, name) modules[name] = {}; return modules[name] end,
  }
  env.loadstring = function(text, name)
    local chunk, err = loadstring(text, name)
    if chunk then setfenv(chunk, env) end
    return chunk, err
  end
  return env, modules
end

---@param content string
---@param env table
---@param name string
---@return nil
local function execute(content, env, name)
  local chunk = assert(loadstring(content, "@" .. name))
  setfenv(chunk, env)
  chunk()
end

---Capture the complete effective override source, including the separate Titan function.
---@param root string
---@param locale string
---@param content string? Executable mutation fixture instead of the pinned file.
---@return table captured Quest/Item lookup rows and named Titan field rows.
function fidelity.capture(root, locale, content)
  local path = root .. "/Localization/lookups/lookupOverrides.lua"
  local env, modules = environment(locale)
  execute(content or lib.readAll(path), env, path)
  return {
    Quest = modules.l10n.questLookupOverrides and modules.l10n.questLookupOverrides() or {},
    Item = modules.l10n.itemLookupOverrides and modules.l10n.itemLookupOverrides() or {},
    Titan = env.Questie.LoadTitanQuestLookupOverrides(),
  }
end

---Derive all Titan translations, including ordinary overrides on Titan-added entities.
---Do not enumerate three current IDs: a new translated Titan entity must enter this oracle.
---@param root string
---@return table rows Named translated fields, keyed by quest ID.
function fidelity.titan(root)
  local env, modules = environment("zhCN")
  local constants = setmetatable({}, { __index = function() return 0 end })
  for _, name in ipairs({ "raceKeys", "classKeys", "factionIDs", "sortKeys", "specialFlags", "questFlags" }) do
    modules.QuestieDB[name] = constants
  end
  modules.ZoneDB = { zoneIDs = constants }
  modules.QuestieProfessions = { professionKeys = constants }
  local path = root .. "/Database/Corrections/titanReforgedQuestFixes.lua"
  execute(lib.readAll(path), env, path)
  local additions = modules.TitanReforgedQuestFixes.LoadQuests()
  local captured = fidelity.capture(root, "zhCN")
  local rows = {}
  for id, row in pairs(captured.Quest) do
    if additions[id] then rows[id] = { name = row[1], objectivesText = row[2] } end
  end
  for id, fields in pairs(captured.Titan) do
    rows[id] = rows[id] or {}
    for name, value in pairs(fields) do rows[id][name] = value end
  end
  return rows
end

---Report one mismatch per row so additions, removals and changes have precise controls.
---@param actual table
---@param expected table
---@return string[] differences
function fidelity.differences(actual, expected)
  local differences, seen = {}, {}
  for id, row in pairs(actual) do
    seen[id] = true
    if not lib.deepEqual(row, expected[id]) then differences[#differences + 1] = tostring(id) end
  end
  for id in pairs(expected) do
    if not seen[id] then differences[#differences + 1] = tostring(id) end
  end
  table.sort(differences)
  return differences
end

---Reproduce Questie's effective lookup table independently of the generator's adapter.
---@param root string
---@param flavor table
---@param typeName string
---@param locale string
---@return table rows Compact translated fields keyed by entity ID.
function fidelity.lookup(root, flavor, typeName, locale)
  local dirs = { Quest = "lookupQuests", Item = "lookupItems", Npc = "lookupNpcs", Object = "lookupObjects" }
  local fields = { Quest = "questLookup", Item = "itemLookup", Npc = "npcNameLookup", Object = "objectLookup" }
  local env, modules = environment(locale)
  local path = root .. "/Localization/lookups/" .. flavor.expansion .. "/" .. dirs[typeName] .. "/" .. locale .. ".lua"
  execute(lib.readAll(path), env, path)
  local lookup = modules.l10n[fields[typeName]][locale]()

  -- This decision is independently read from the actual TOC, not the production inventory.
  local tocNames = { Vanilla = "Classic", TBC = "BCC", Wrath = "WOTLKC", Cata = "Cata", Mists = "Mists" }
  local toc = lib.readAll(root .. "/Questie-" .. tocNames[flavor.name] .. ".toc")
  if toc:find("Localization\\lookups\\lookupOverrides.lua", 1, true) then
    local overrides = fidelity.capture(root, locale)[typeName] or {}
    for id, row in pairs(overrides) do lookup[id] = row end
  end

  local rows = {}
  for id, row in pairs(lookup) do
    local scalar = typeName == "Item" or typeName == "Object"
    local name = scalar and row or row[1]
    if type(name) == "string" then
      name = name:gsub("[%z\1-\31\127]", ""):match("^[ \t\r\n]*(.-)[ \t\r\n]*$")
      if name == "" then name = nil end
    end
    local second
    if typeName == "Quest" then
      second = row[2]
      if type(second) == "string" and second ~= "" then second = { second }
      elseif type(second) ~= "table" or next(second) == nil then second = nil end
    elseif typeName == "Npc" then
      second = row[2]
      if type(second) == "string" then
        second = second:gsub("[%z\1-\31\127]", ""):match("^[ \t\r\n]*(.-)[ \t\r\n]*$")
        if second == "" then second = nil end
      end
    end
    if name ~= nil or second ~= nil then rows[id] = { name, second } end
  end
  return rows
end

---Compare generated columns against an independent lookup, including entity filtering.
---The full sweep and mutation controls use this same comparison path.
---@param generator table
---@param typeName string
---@param actual table Extracted compact fields and locale slots.
---@param expected table Independent compact rows by ID.
---@param ids number[] Ascending admitted entity IDs.
---@param localeIndex integer
---@return string[] differences
function fidelity.compare(generator, typeName, actual, expected, ids, localeIndex)
  local block = generator.buildBlock(typeName, actual, ids, localeIndex)
  local actualRows, expectedRows = {}, {}
  for position, id in ipairs(ids) do
    local row = {}
    for field, column in ipairs(block) do row[field] = column[position] end
    if next(row) then actualRows[id] = row end
    expectedRows[id] = expected[id]
  end
  return fidelity.differences(actualRows, expectedRows)
end

---Load generator modules and their nested Lua sources without installing process globals.
---The entity loader mutates Questie as well as replacing globals, so restoring only top-level
---bindings would not suffice. Keep its mutable client tables and compiled chunks private.
---@return table env
local function generatorEnvironment()
  local env = setmetatable({ Questie = {}, C_AddOns = {}, Enum = {}, LibStub = false }, { __index = _G })
  env._G = env
  ---@param path string
  ---@return function? chunk
  ---@return string? error
  env.loadfile = function(path)
    local chunk, err = loadfile(path)
    if chunk then setfenv(chunk, env) end
    return chunk, err
  end
  ---@param text string
  ---@param name string?
  ---@return function? chunk
  ---@return string? error
  env.loadstring = function(text, name)
    local chunk, err = loadstring(text, name)
    if chunk then setfenv(chunk, env) end
    return chunk, err
  end
  ---@param path string
  ---@return any
  env.dofile = function(path) return assert(env.loadfile(path))() end
  return env
end

---Compare all generated translations for all five flavors and nine locales.
---@param check fun(condition: boolean, message: string)
---@param root string Pinned Questie checkout.
---@return nil
function fidelity.run(check, root)
  lib.assertQuestiePin(root)
  local env = generatorEnvironment()
  local generator = env.dofile("generator/l10n.lua")
  local flavorLoader = env.dofile("generator/flavor.lua")
  for _, flavor in ipairs(config.flavors) do
    local loaded = flavorLoader.load(flavor)
    for _, typeName in ipairs({ "Quest", "Item", "Npc", "Object" }) do
      local known, ids = {}, {}
      for id in pairs(loaded[typeName].entities) do known[id] = true; ids[#ids + 1] = id end
      table.sort(ids)
      local actual = generator.extract(config.paths.l10n, flavor, typeName, known)
      for localeIndex, locale in ipairs(config.locales) do
        local expected = fidelity.lookup(root, flavor, typeName, locale)
        local differences = fidelity.compare(generator, typeName, actual, expected, ids, localeIndex)
        check(#differences == 0, flavor.name .. " " .. typeName .. " " .. locale ..
          " complete localization: " .. table.concat(differences, ", "))
      end
    end
    loaded = nil
    collectgarbage("collect")
  end
end

return fidelity
