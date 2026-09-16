-- Local translation sources retain their imported executable format. Keep flavor
-- applicability, sandboxing, and whole-row replacement semantics at this input boundary.
-- Generation receives named translation fields; false in a Static Translation Correction
-- explicitly clears an imported field so an omitted override field cannot retain stale text.

local inputs = {}

---@type table<string, table>
inputs.types = {
  Quest = {
    dir = "lookupQuests", field = "questLookup",
    fields = { { name = "name", from = 1 }, { name = "objectivesText", from = 2, list = true } },
  },
  Npc = {
    dir = "lookupNpcs", field = "npcNameLookup",
    fields = { { name = "name", from = 1 }, { name = "subName", from = 2 } },
  },
  Item = { dir = "lookupItems", field = "itemLookup", scalar = true, fields = { { name = "name" } } },
  Object = { dir = "lookupObjects", field = "objectLookup", scalar = true, fields = { { name = "name" } } },
}

-- Override applicability follows the original flavor TOCs. Selection and preflight use
-- the same inventory; another correction source belongs here, not in extract().
---@type table[]
inputs.staticSources = {
  {
    path = "lookupOverrides.lua",
    expansions = { TBC = true, Wotlk = true, Cata = true, MoP = true },
    fields = { Quest = "questLookupOverrides", Item = "itemLookupOverrides" },
  },
}

---@param root string
---@param flavor table
---@param typeCfg table
---@param locale string
---@return string path
function inputs.lookupPath(root, flavor, typeCfg, locale)
  return ("%s/%s/%s/%s.lua")
    :format(root, flavor.expansion, typeCfg.dir, locale)
end

---Select imported Static Translation Correction sources for one flavor and entity type.
---@param flavor table
---@param typeName string
---@return table[] sources
function inputs.correctionSources(flavor, typeName)
  local sources = {}
  for _, source in ipairs(inputs.staticSources) do
    if source.expansions[flavor.expansion] and source.fields[typeName] then
      sources[#sources + 1] = source
    end
  end
  return sources
end

---Run one locale in a private environment, including any nested loadstring payloads.
---@param locale string
---@return table environment
---@return table module
local function environment(locale)
  local module = { questLookup = {}, npcNameLookup = {}, itemLookup = {}, objectLookup = {} }
  local modules = { l10n = module, QuestieDB = {} }
  local env = setmetatable({ Questie = {} }, { __index = _G })
  env._G = env
  env.GetLocale = function() return locale end
  env.QuestieLoader = { ImportModule = function(_, name)
    assert(modules[name], "unexpected localization import: " .. tostring(name))
    return modules[name]
  end }
  env.loadstring = function(text, name)
    local chunk, err = loadstring(text, name)
    if chunk then setfenv(chunk, env) end
    return chunk, err
  end
  return env, module
end

---@param path string
---@param env table
---@return nil
local function execute(path, env)
  local chunk, err = loadfile(path)
  assert(chunk, "Cannot load " .. path .. ": " .. tostring(err))
  setfenv(chunk, env)
  chunk()
end

---Convert upstream lookup rows into named translation fields, preserving display cleanup.
---@param payload table
---@param typeCfg table
---@param replaceRows boolean Clear fields omitted from whole-row overrides.
---@return table rows
local function translationRows(payload, typeCfg, replaceRows)
  local rows = {}
  for id, row in pairs(payload) do
    local fields = {}
    for _, field in ipairs(typeCfg.fields) do
      local value
      if typeCfg.scalar then value = row else value = row[field.from] end
      if field.list then
        if type(value) == "string" and value ~= "" then value = { value }
        elseif type(value) ~= "table" or next(value) == nil then value = nil end
      elseif type(value) == "string" then
        value = value:gsub("[%z\1-\31\127]", ""):match("^[ \t\r\n]*(.-)[ \t\r\n]*$")
        if value == "" then value = nil end
      end
      if value ~= nil then fields[field.name] = value
      elseif replaceRows then fields[field.name] = false end
    end
    rows[id] = fields
  end
  return rows
end

---Import base translations and ordered Static Translation Corrections independently.
---The executable source's row replacement becomes explicit field clearing at this seam.
---@param root string Local localization directory.
---@param flavor table
---@param typeName string
---@param locale string
---@return table base Named fields by entity ID.
---@return table[] corrections Ordered sets of named field corrections.
function inputs.load(root, flavor, typeName, locale)
  local typeCfg = assert(inputs.types[typeName])
  local env, module = environment(locale)
  execute(inputs.lookupPath(root, flavor, typeCfg, locale), env)
  local payload = module[typeCfg.field][locale]
  if type(payload) == "function" then payload = payload() end
  local base = translationRows(payload or {}, typeCfg, false)
  local corrections = {}
  for _, source in ipairs(inputs.correctionSources(flavor, typeName)) do
    local field = source.fields[typeName]
    module[field] = nil
    execute(root .. "/" .. source.path, env)
    local rows = module[field]
    if type(rows) == "function" then rows = rows() end
    corrections[#corrections + 1] = translationRows(rows or {}, typeCfg, true)
  end
  return base, corrections
end

return inputs
